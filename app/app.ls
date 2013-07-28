angular.module "g0v.tw" <[firebase]>
.controller EventCtrl: <[$scope angularFireCollection]> ++ ($scope, angularFireCollection) ->
  url = "https://g0vsite.firebaseio.com"
  root = new Firebase(url)
  $scope.events = angularFireCollection root.child("feed/events/articles").limit(2)
