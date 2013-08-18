var deferSrcSetters, show;
deferSrcSetters = [];
angular.element(document).ready(function(){
  var i$, ref$, len$, func, results$ = [];
  for (i$ = 0, len$ = (ref$ = deferSrcSetters).length; i$ < len$; ++i$) {
    func = ref$[i$];
    results$.push(func());
  }
  return results$;
});
angular.module("g0v.tw", ['firebase']).factory({
  fireRoot: ['angularFireCollection'].concat(function(angularFireCollection){
    var url;
    url = "https://g0vsite.firebaseio.com";
    return new Firebase(url);
  })
}).directive('deferSrc', function(){
  return {
    restrict: 'A',
    link: function(scope, iElement, iAttrs, controller){
      var src;
      src = iElement.attr('defer-src');
      return deferSrcSetters.push(function(){
        return iElement.attr('src', src);
      });
    }
  };
}).controller({
  EventCtrl: ['$scope', 'angularFireCollection', 'fireRoot'].concat(function($scope, angularFireCollection, fireRoot){
    $scope.events = angularFireCollection(fireRoot.child("feed/events/articles").limit(2));
    return $scope.$watch('events.length', function(){
      if ($scope.events.length) {
        return $('.event-loading').hide();
      }
    });
  })
}).controller({
  BlogCtrl: ['$scope', 'angularFireCollection', 'fireRoot'].concat(function($scope, angularFireCollection, fireRoot){
    $scope.articles = angularFireCollection(fireRoot.child("feed/blog/articles").limit(10));
    return $scope.$watch('articles.length', function(){
      if ($scope.articles.length) {
        return $('.blog-loading').hide();
      }
    });
  })
}).controller({
  FeaturedCtrl: ['$scope', 'angularFireCollection'].concat(function($scope, angularFireCollection){
    var g0vhub;
    g0vhub = new Firebase("https://g0vhub.firebaseio.com/projects");
    $scope.projects = angularFireCollection(g0vhub);
    $scope.nextProject = function(){
      if ($scope.idx === void 8) {
        return;
      }
      $('#prj-img').css('opacity', 0);
      ++$scope.idx;
      return $scope.idx %= $scope.featured.length;
    };
    $scope.$watch('projects.length', function(){
      var res$, i$, ref$, len$, p;
      res$ = [];
      for (i$ = 0, len$ = (ref$ = $scope.projects).length; i$ < len$; ++i$) {
        p = ref$[i$];
        if (p.thumbnail) {
          res$.push(p);
        }
      }
      $scope.featured = res$;
      return $scope.idx = Math.floor(Math.random() * $scope.featured.length);
    });
    return $scope.$watch('idx', function(_, idx){
      if (idx !== void 8) {
        return $scope.project = $scope.featured[idx];
      }
    });
  })
}).controller({
  BuildIdCtrl: ['$scope'].concat(function($scope){
    return $.get("/build_id.txt").done(function(buildId){
      return $scope.buildId = buildId;
    });
  })
});
show = function(){
  var prjImg, h;
  prjImg = $('#prj-img');
  prjImg.animate({
    opacity: 1
  }, 500);
  h = [40 + prjImg.height()][0];
  return $('#prj-img-div').animate({
    height: h + "px"
  }, 500);
};