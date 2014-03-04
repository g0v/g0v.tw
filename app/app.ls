defer-src-setters = []

angular.element(document).ready ->
  for func in defer-src-setters
    func!

# angular.config ['$httpProvider' ($httpProvider) ->
#   $httpProvider.defaults.useXDomain = true
#   delete $httpProvider.defaults.headers.common['X-Requested-With']]

angular.module "g0v.tw" <[firebase btford.markdown]>
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

.controller CommuniqueCtrl: <[$scope $http]> ++ ($scope, $http) ->
  $http.get 'http://g0v-communique-api.herokuapp.com/api/1.0/entry/all?start=2014/02'
  .success (data, status, headers, config)->
    $scope.communique = data[0]
  .error (data, status, headers, config) ->
    $scope.message = status

  $scope.nextCommunique = ->

.controller BuildIdCtrl: <[$scope]> ++ ($scope) ->
  $scope.buildId = window.global.config.BUILD


show = ->
  prj-img = $ \#prj-img
  prj-img.animate {opacity: 1}, 500
  [h] = [40 + prj-img.height!]
  $ \#prj-img-div .animate {height: h+"px"}, 500

<- $
$ '.ui.dropdown' .dropdown on: \hover, transition: \fade
