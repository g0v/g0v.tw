angular.module("g0v.tw", ['firebase']).controller({
  EventCtrl: ['$scope', 'angularFire'].concat(function($scope, angularFire){
    var url, root;
    url = "https://g0vsite.firebaseio.com";
    root = new Firebase(url);
    return angularFire(root.child("feed/events/articles"), $scope, 'events', {});
  })
});