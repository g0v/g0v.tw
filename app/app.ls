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
  url = "https://g0vsite.firebaseio.com"
  new Firebase(url)

.factory eventsPromise: <[$http]> ++ ($http) ->
  api-endpoint = 'http://www.kimonolabs.com/api/dzdrrgx6'
  config = {
    params: {
      apikey: 'c626b7443a0cbcb5525f492411d10567',
      callback: 'JSON_CALLBACK'
    }
  }
  $http.jsonp api-endpoint, config .then (response) ->
    results = response.data.results
    transform-fn =  (obj) ->
      { link: obj.event.href, title: obj.event.text }
    recent  = results.recent.map transform-fn
    past    = results.past.map   transform-fn
    return { recent: recent, past: past }

# defer iframe loading to stop blocking angular.js for loading
.directive \deferSrc ->
  return {
    restrict: 'A',
    link: (scope, iElement, iAttrs, controller) ->
      src = iElement.attr 'defer-src'
      defer-src-setters.push ->
        iElement.attr 'src', src
  }

.controller EventCtrl: <[$scope eventsPromise]> ++ ($scope, eventsPromise) ->
  eventsPromise.then (events) ->
    recent = events.recent.map (it) -> it.finished = false; it
    past = events.past.map (it) -> it.finished = true; it
    $scope.events = (recent ++ past)

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
.controller CommuniqueCtrl: <[$scope $http $element]> ++ ($scope, $http, $element) ->
  # Use Http get the Json from communiqueAPI
  $http.get 'http://g0v-communique-api.herokuapp.com/api/1.0/entry/all?limit=50'
  .success (data, status, headers, config)->
    # $scope.idx = Math.floor Math.random! * data.length   # set random Communique entries display
    $scope.idx = 0
    $scope.nextCommunique = ->
      return if $scope.idx is void
      ++$scope.idx
      $scope.idx %= data.length

    $scope.$watch 'idx' (_, idx) ->
      $scope.communique = data[idx] unless idx is void
      # add url in the communique text
      for url in $scope.communique.urls
        $scope.communique.content = $scope.communique.content.replace url.name, '<a target="_blank" href="' + url.url + '">' + url.name + '</a>'
      $element.find('.description').html $scope.communique.content

  .error (data, status, headers, config) ->
    $scope.message = status

.controller BuildIdCtrl: <[$scope]> ++ ($scope) ->
  require!<[config.jsenv]>
  $scope.buildId = config.BUILD

.controller langCtrl: <[$scope $window]> ++ ($scope, $window) ->
  $scope.changeLang = (lang) ->
    page = $window.location.pathname.split('/').2
    $window.location.href = '/' + lang + '/' + page
show = ->
  prj-img = $ \#prj-img
  prj-img.animate {opacity: 1}, 500
  [h] = [40 + prj-img.height!]
  $ \#prj-img-div .animate {height: h+"px"}, 500

<- $
$ '.ui.dropdown' .dropdown on: \hover, transition: \fade
