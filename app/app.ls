angular.module "g0v.tw" <[firebase]>
.controller EventCtrl: <[$scope angularFire]> ++ ($scope, angularFire) ->
  url = "https://g0vsite.firebaseio.com"
  root = new Firebase(url)
  angularFire root.child("feed/events/articles"), $scope, 'events', {}
