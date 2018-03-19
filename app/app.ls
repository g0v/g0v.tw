defer-src-setters = []

angular.element(document).ready ->
  for func in defer-src-setters
    func!

angular.module "g0v.tw" <[firebase btford.markdown pascalprecht.translate]>

# Set CORS Config
.config <[$httpProvider $translateProvider ]> ++ ($httpProvider, $translateProvider) ->
  $httpProvider.defaults.useXDomain = true
  delete $httpProvider.defaults.headers.common['X-Requested-With']

  $translateProvider.useStaticFilesLoader do
    prefix: '/translations/'
    suffix: '.json'

  lang = window.location.pathname.split('/').1
  lang = window.navigator.userLanguage or window.navigator.language if lang.match 'html' or document.title.match '找不到'
  if lang is 'zh-TW' or lang is 'en-US'
    $translateProvider.preferredLanguage lang

.factory fireRoot: <[angularFireCollection]> ++ (angularFireCollection) ->
  url = "https://g0vfeedthefire.firebaseio.com"
  new Firebase(url)

# defer iframe loading to stop blocking angular.js for loading
.directive \deferSrc ->
  return {
    restrict: 'A',
    link: (scope, iElement, iAttrs, controller) ->
      src = iElement.attr 'defer-src'
      defer-src-setters.push ->
        iElement.attr 'src', src
  }

.controller EventCtrl: <[$q $http $scope]> ++ ($q, $http, $scope) ->
  $scope.events = []

  $scope.event-sources = []

  $scope.events-of = (url) ->
    defer = $q.defer()
    $http.get(url, {}).success (result) ->
      defer.resolve([event if moment(event.published).diff(moment()) > 0 for event in result.entry])
    return defer.promise

  $scope.from-smallthon-config= ->
    defer = $q.defer!
    result <- $http
      .get '/data/small-thon.json'
      .success
    defer.resolve result
    return defer.promise

  { data } <- $scope
    .from-smallthon-config!
    .then
  $scope.event-sources = data.map -> it + "/events.json"

  $scope.event-sources.map (source) ->
    $scope.events-of(source)
      .then (events) ->
        $scope.events = events.concat($scope.events)

.controller BlogCtrl: <[$scope angularFireCollection fireRoot]> ++ ($scope, angularFireCollection, fireRoot) ->
  $scope.articles = angularFireCollection fireRoot.child("feed/blog/articles").limit 2

.controller FeaturedCtrl: <[$scope angularFireCollection]> ++ ($scope, angularFireCollection) ->
  g0vhub = new Firebase("https://g0vhub.firebaseio.com/projects")
  $scope.projects = angularFireCollection g0vhub
  $scope.nextProject = ->
    return if $scope.idx is void
    $ \#prj-img .css \opacity, 0
    ++$scope.idx
    $scope.idx %= $scope.featured.length
  $scope.$watch 'projects.length' ->
    $scope.featured = [p for p in $scope.projects when p.thumbnail]
    $scope.idx = Math.floor Math.random! * $scope.featured.length

  $scope.$watch 'idx' (_, idx) ->
    $scope.project = $scope.featured[idx] unless idx is void

# Communique scrolling text function. Get the 50 newest communiques entry from g0v.hackpad
.controller CommuniqueCtrl: <[$scope $http $element $sce]> ++ ($scope, $http, $element, $sce) ->
  # Use Http get the Json from communiqueAPI
  $http.get 'http://g0v-communique-api.herokuapp.com/api/1.0/entry/all?limit=50'
  .success (data, status, headers, config) ->
    # $scope.idx = Math.floor Math.random! * data.length   # set random Communique entries display
    $scope.idx = 0
    $scope.nextCommunique = ->
      return if $scope.idx is void
      ++$scope.idx
      $scope.idx %= data.length

    $scope.$watch 'idx' (_, idx) ->
      idx = $scope.idx
      $scope.communique = data[idx] unless idx is void
      # add url in the communique text
      for url in $scope.communique.urls
        $scope.communique.content = $scope.communique.content.replace url.name, '<a target="_blank" href="' + url.url + '">' + url.name + '</a>'
      $scope.communique.content = $sce.trustAsHtml $scope.communique.content

  .error (data, status, headers, config) ->
    $scope.communique.content = $sce.trustAsHtml status

.controller BuildIdCtrl: <[$scope]> ++ ($scope) ->
  require!<[config.jsenv]>
  $scope.buildId = config.BUILD

.controller langCtrl: <[$scope $window]> ++ ($scope, $window) ->
  $scope.changeLang = (lang) ->
    page = $window.location.pathname.split('/').2
    $window.location.href = '/' + lang + '/' + page

.controller SearchCtrl: <[$http $scope]> ++ ($http, $scope) ->
  ENTRY_PER_PAGE = 10

  $scope.input = ''
  $scope.start = 0
  $scope.total = 0
  $scope.result = []
  $scope.hasPrev = false
  $scope.hasNext = false

  $scope.date = -> new Date(1000 * it).toDateString!

  $scope.trunc = (str, n) ->
    if str.length > n then str.substr(0, n-1) + '…' else str

  search = ->
    query =
      query:
        query_string:
          query: $scope.input
      from: $scope.start
      highlight:
        fields:
          content: {}
      aggs:
        source_count:
          terms:
            field: 'source'
      sort: [{ updated_at: 'desc' }]
    { hits: { hits: result, total } } <- $http
      .get 'https://api.search.g0v.io/query.php?query=' + encodeURIComponent(JSON.stringify(query))
      .success
    $scope.total = total
    $scope.hasPrev = $scope.start isnt 0
    $scope.hasNext = $scope.start + ENTRY_PER_PAGE < $scope.total
    $scope.result = result.map (._source)

  $scope.submit = ->
    $scope.start = 0
    search!

  $scope.prev = ->
    $scope.start = if $scope.start is 0
      then 0
      else $scope.start - ENTRY_PER_PAGE
    scrollTo 0 0
    search!

  $scope.succ = ->
    $scope.start = if $scope.start + ENTRY_PER_PAGE >= $scope.total
      then $scope.start
      else $scope.start + ENTRY_PER_PAGE
    scrollTo 0 0
    search!

show = ->
  prj-img = $ \#prj-img
  prj-img.animate {opacity: 1}, 500
  [h] = [40 + prj-img.height!]
  $ \#prj-img-div .animate {height: h+"px"}, 500

<- $
$ '.ui.dropdown' .dropdown on: \hover, transition: \fade

<- $
if window.location.pathname.match /projects.html$/
  $ '.navbar-wrapper' .stickUp do
    parts: {
      0: 'openGov',
      1: 'openData',
      2: 'socEngage',
      3: 'newMedia',
      4: 'policyFeedback',
      5: 'comCollaboration'
      },
    itemClass: 'menuItem',
    itemHover: 'active',
    topMargin: 'auto'

if window.location.pathname.match /talk.html$/
  $ '.navbar-wrapper' .stickUp do
    parts: {
      0: 'newtalks',
      1: 'talkvideo',
      2: 'alltalks',
      3: 'invitetalks'
      },
    itemClass: 'menuItem',
    itemHover: 'active',
    topMargin: 'auto'

<- $
$ 'a[href^="#"]' .bind 'click.smoothscroll', (e)->
  e.preventDefault();
  target = this.hash
  $ 'html, body' .stop!.animate {'scrollTop': $ target .offset!.top}, 900, 'swing', ->
    window.location.hash = target;

<-! $
$ '.item .meta' .each ->
  $_ = $ @
  if $_.text! is /\d{4}\/\d{1,2}\/\d{1,2}$/
    return if 30 < moment!diff moment(that.0), \days
    $_.closest \.item .add-class \recent-talk
