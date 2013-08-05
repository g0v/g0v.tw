angular.module "g0v.tw" <[firebase]>
.factory fireRoot: <[angularFireCollection]> ++ (angularFireCollection) ->
  url = "https://g0vsite.firebaseio.com"
  new Firebase(url)

.controller EventCtrl: <[$scope angularFireCollection fireRoot]> ++ ($scope, angularFireCollection, fireRoot) ->
  $scope.events = angularFireCollection fireRoot.child("feed/events/articles").limit(2)

.controller BlogCtrl: <[$scope angularFireCollection fireRoot]> ++ ($scope, angularFireCollection, fireRoot) ->
  $scope.articles = angularFireCollection fireRoot.child("feed/blog/articles").limit 10

.controller FeaturedCtrl: <[$scope angularFireCollection]> ++ ($scope, angularFireCollection) ->
  g0vhub = new Firebase("https://g0vhub.firebaseio.com/projects")
  $scope.projects = angularFireCollection g0vhub
  $scope.nextProject = ->
    return if $scope.idx is void
    ++$scope.idx
    $scope.idx %= $scope.featured.length
  $scope.$watch 'projects.length' ->
    $scope.featured = [p for p in $scope.projects when p.thumbnail]
    $scope.idx = Math.floor Math.random! * $scope.featured.length

  $scope.$watch 'idx' (_, idx) ->
    $scope.project = $scope.featured[idx] unless idx is void
