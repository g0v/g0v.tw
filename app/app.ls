angular.module "g0v.tw" <[firebase]>
.factory fireRoot: <[angularFireCollection]> ++ (angularFireCollection) ->
  url = "https://g0vsite.firebaseio.com"
  new Firebase(url)

.controller EventCtrl: <[$scope angularFireCollection fireRoot]> ++ ($scope, angularFireCollection, fireRoot) ->
  $scope.events = angularFireCollection fireRoot.child("feed/events/articles").limit(2)

.controller BlogCtrl: <[$scope angularFireCollection fireRoot]> ++ ($scope, angularFireCollection, fireRoot) ->
  $scope.articles = angularFireCollection fireRoot.child("feed/blog/articles").limit 10
