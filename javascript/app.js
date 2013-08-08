var show,urlPath;
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

/* active status control for gov.tw main navigatin */
$(function(){
  urlPath = location.pathname || '/'; 
  $('#nav_main a[href="' + urlPath + '"] .nav_tab').addClass('active');
});
