angular.module("g0v.tw", ['firebase']).factory({
  fireRoot: ['angularFireCollection'].concat(function(angularFireCollection){
    var url;
    url = "https://g0vsite.firebaseio.com";
    return new Firebase(url);
  })
}).controller({
  EventCtrl: ['$scope', 'angularFireCollection', 'fireRoot'].concat(function($scope, angularFireCollection, fireRoot){
    return $scope.events = angularFireCollection(fireRoot.child("feed/events/articles").limit(2));
  })
}).controller({
  BlogCtrl: ['$scope', 'angularFireCollection', 'fireRoot'].concat(function($scope, angularFireCollection, fireRoot){
    return $scope.articles = angularFireCollection(fireRoot.child("feed/blog/articles").limit(10));
  })
});