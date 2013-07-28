angular.module("g0v.tw", ['firebase']).controller({
  EventCtrl: ['$scope', 'angularFireCollection'].concat(function($scope, angularFireCollection){
    var url, root;
    url = "https://g0vsite.firebaseio.com";
    root = new Firebase(url);
    return $scope.events = angularFireCollection(root.child("feed/events/articles").limit(2));
  })
});