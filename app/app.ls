defer-src-setters = []

angular.element(document).ready ->
  for func in defer-src-setters
    func!

angular.module "g0v.tw" <[firebase btford.markdown]>

# Set CORS Config
.config ['$httpProvider' ($httpProvider) ->
  $httpProvider.defaults.useXDomain = true
  delete $httpProvider.defaults.headers.common['X-Requested-With']]

.factory fireRoot: <[angularFireCollection]> ++ (angularFireCollection) ->
  url = "https://g0vsite.firebaseio.com"
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

.controller EventCtrl: <[$scope angularFireCollection fireRoot]> ++ ($scope, angularFireCollection, fireRoot) ->
  $scope.events = angularFireCollection fireRoot.child("feed/events/articles").limit(2)

.controller BlogCtrl: <[$scope angularFireCollection fireRoot]> ++ ($scope, angularFireCollection, fireRoot) ->
  $scope.articles = angularFireCollection fireRoot.child("feed/blog/articles").limit 4

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
    $scope.communiques = data
    $scope.check = 0
    $scope.idx = 0
    $scope.nextCommunique = ->
      return if $scope.idx is void
      ++$scope.idx
      $scope.idx %= $scope.communiques.length

    $scope.$watch 'idx' (_, idx) ->
      if $scope.check is 0
        $scope.check = 1
      else
        idx++
      idx %= $scope.communiques.length
      $scope.communique = $scope.communiques[idx] unless idx is void
      # add url in the communique text
      for url in $scope.communique.urls
        $scope.communique.content = $scope.communique.content.replace url.name, '<a target="_blank" href="' + url.url + '">' + url.name + '</a>'
      $element.find('.description').html $scope.communique.content

  .error (data, status, headers, config) ->
    $scope.message = status

.controller BuildIdCtrl: <[$scope]> ++ ($scope) ->
  require!<[config.jsenv]>
  $scope.buildId = config.BUILD


show = ->
  prj-img = $ \#prj-img
  prj-img.animate {opacity: 1}, 500
  [h] = [40 + prj-img.height!]
  $ \#prj-img-div .animate {height: h+"px"}, 500

<- $
$ '.ui.dropdown' .dropdown on: \hover, transition: \fade
