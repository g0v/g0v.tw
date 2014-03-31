(function(){
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
  angular.module("g0v.tw", ['firebase', 'btford.markdown']).config([
    '$httpProvider', function($httpProvider){
      var ref$, ref1$;
      $httpProvider.defaults.useXDomain = true;
      return ref1$ = (ref$ = $httpProvider.defaults.headers.common)['X-Requested-With'], delete ref$['X-Requested-With'], ref1$;
    }
  ]).factory({
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
      return $scope.events = angularFireCollection(fireRoot.child("feed/events/articles").limit(2));
    })
  }).controller({
    BlogCtrl: ['$scope', 'angularFireCollection', 'fireRoot'].concat(function($scope, angularFireCollection, fireRoot){
      return $scope.articles = angularFireCollection(fireRoot.child("feed/blog/articles").limit(4));
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
    CommuniqueCtrl: ['$scope', '$http', '$element'].concat(function($scope, $http, $element){
      return $http.get('http://g0v-communique-api.herokuapp.com/api/1.0/entry/all?limit=50').success(function(data, status, headers, config){
        $scope.idx = 0;
        $scope.nextCommunique = function(){
          if ($scope.idx === void 8) {
            return;
          }
          ++$scope.idx;
          return $scope.idx %= data.length;
        };
        return $scope.$watch('idx', function(_, idx){
          var i$, ref$, len$, url;
          if (idx !== void 8) {
            $scope.communique = data[idx];
          }
          for (i$ = 0, len$ = (ref$ = $scope.communique.urls).length; i$ < len$; ++i$) {
            url = ref$[i$];
            $scope.communique.content = $scope.communique.content.replace(url.name, '<a target="_blank" href="' + url.url + '">' + url.name + '</a>');
          }
          return $element.find('.description').html($scope.communique.content);
        });
      }).error(function(data, status, headers, config){
        return $scope.message = status;
      });
    })
  }).controller({
    BuildIdCtrl: ['$scope'].concat(function($scope){
      return $scope.buildId = window.global.config.BUILD;
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
  $(function(){
    return $('.ui.dropdown').dropdown({
      on: 'hover',
      transition: 'fade'
    });
  });
}).call(this);
