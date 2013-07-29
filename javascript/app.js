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
}).controller({
  FeaturedCtrl: ['$scope', 'angularFireCollection'].concat(function($scope, angularFireCollection){
    var g0vhub;
    g0vhub = new Firebase("https://g0vhub.firebaseio.com/projects");
    $scope.projects = angularFireCollection(g0vhub);
    return $scope.$watch('projects.length', function(){
      var p;
      return $scope.featured = (function(){
        var i$, ref$, len$, results$ = [];
        for (i$ = 0, len$ = (ref$ = $scope.projects).length; i$ < len$; ++i$) {
          p = ref$[i$];
          if (p.thumbnail) {
            results$.push(p);
          }
        }
        return results$;
      }());
    });
  })
});