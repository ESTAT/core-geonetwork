(function() {

  goog.provide('gn_search_estat_directive');

  var module = angular.module('gn_search_estat_directive', []);

  module.directive('gnInfoList', ['gnMdView',
    function(gnMdView) {
      return {
        restrict: 'A',
        replace: true,
        templateUrl: '../../catalog/views/estat/directives/' +
            'partials/infolist.html',
        link: function linkFn(scope, element, attr) {
          scope.showMore = function(isDisplay) {
            var div = $('#gn-info-list' + this.md.getUuid());
            $(div.children()[isDisplay ? 0 : 1]).addClass('hidden');
            $(div.children()[isDisplay ? 1 : 0]).removeClass('hidden');
          };
          scope.go = function(uuid) {
            gnMdView(index, md, records);
            gnMdView.setLocationUuid(uuid);
          };
        }
      };
    }
  ]);

  module.directive('gnAttributeTableRenderer', ['gnMdView',
    function(gnMdView) {
      return {
        restrict: 'A',
        replace: true,
        templateUrl: '../../catalog/views/estat/directives/' +
        'partials/attributetable.html',
        scope: {
          attributeTable: '=gnAttributeTableRenderer'
        },
        link: function linkFn(scope, element, attrs) {
          if (angular.isDefined(scope.attributeTable) &&
            !angular.isArray(scope.attributeTable)) {
            scope.attributeTable = [scope.attributeTable];
          }
        }
      };
    }
  ]);

  module.directive('gnLinksBtn', [ 'gnTplResultlistLinksbtn',
    function(gnTplResultlistLinksbtn) {
      return {
        restrict: 'E',
        replace: true,
        scope: true,
        templateUrl: gnTplResultlistLinksbtn
      };
    }
  ]);

  module.directive('gnMdActionsMenu', ['gnMetadataActions',
    function(gnMetadataActions) {
      return {
        restrict: 'A',
        replace: true,
        templateUrl: '../../catalog/views/estat/directives/' +
            'partials/mdactionmenu.html',
        link: function linkFn(scope, element, attrs) {
          scope.mdService = gnMetadataActions;
          scope.md = scope.$eval(attrs.gnMdActionsMenu);
          
          scope.$watch(attrs.gnMdActionsMenu, function(a) {
            scope.md = a;
          });

          scope.getScope = function() {
            return scope;
          }
        }
      };
    }
  ]);

  module.directive('gnPeriodChooser', [
    function() {
      return {
        restrict: 'A',
        replace: true,
        templateUrl: '../../catalog/views/estat/directives/' +
            'partials/periodchooser.html',
        scope: {
          label: '@gnPeriodChooser',
          dateFrom: '=',
          dateTo: '='
        },
        link: function linkFn(scope, element, attr) {
          var today = moment();
          scope.format = 'YYYY-MM-DD';
          scope.options = ['today', 'yesterday', 'thisWeek', 'thisMonth',
            'last3Months', 'last6Months', 'thisYear'];
          scope.setPeriod = function(option) {
            if (option === 'today') {
              var date = today.format(scope.format);
              scope.dateFrom = date;
            } else if (option === 'yesterday') {
              var date = today.clone().subtract(1, 'day')
                .format(scope.format);
              scope.dateFrom = date;
              scope.dateTo = today.format(scope.format);
              return;
            } else if (option === 'thisWeek') {
              scope.dateFrom = today.clone().startOf('week')
                .format(scope.format);
            } else if (option === 'thisMonth') {
              scope.dateFrom = today.clone().startOf('month')
                .format(scope.format);
            } else if (option === 'last3Months') {
              scope.dateFrom = today.clone().startOf('month').
                  subtract(3, 'month').format(scope.format);
            } else if (option === 'last6Months') {
              scope.dateFrom = today.clone().startOf('month').
                  subtract(6, 'month').format(scope.format);
            } else if (option === 'thisYear') {
              scope.dateFrom = today.clone().startOf('year')
                .format(scope.format);
            }
            scope.dateTo = today.add(1, 'day').format(scope.format);
          };
        }
      };
    }
  ]);
  
  module.directive('scrollToItem', [
     function() {                                                      
	    return {                                                                                 
	        restrict: 'A',                                                                       
	        scope: {                                                                             
	            scrollTo: "@"                                                                    
	        },                                                                                   
	        link: function(scope, $elm,attr) {                                                   
	            $elm.on('click', function() {                              
	                $('html,body').animate({scrollTop: $(scope.scrollTo).offset().top }, "slow");
	            });                                                                              
	        }                                                                                    
	    }
	  }
     ]);
     
     module.directive('ecBreadcrumb', ['$location',
       function(location) {
       return {
           restrict: 'A',
           replace: true,
           templateUrl: '../../catalog/views/estat/directives/partials/ecbreadcrumb.html',
           link: function linkFn(scope, element, attr) {
        	   updateBreadcrumb = function(path){
	            	 if (path == "/home"){
	            		 scope.ecbreadcrumb = [];
	            	 }
	            	 else {
	            		 scope.ecbreadcrumb = path.split('/');
	            	 }
        	   }
        	   updateBreadcrumb(location.path());
        	   scope.$on('$locationChangeSuccess', function(next, current) {
            	   updateBreadcrumb(location.path());
             });
           }
  	    }
  	  }
     ]);
//      $scope.$on('$locationChangeSuccess', function(next, current) {
//        $scope.activeTab = $location.path().
//            match(/^(\/[a-zA-Z0-9]*)($|\/.*)/)[1];
     
     
     
     module.directive('setClassWhenAtTop', ['$window', '$timeout', '$document',
      function($window, $timeout, $document) {
       var $win = angular.element($window); // wrap window object as jQuery object

       return {
           restrict: 'A',
           link: function (scope, element, attrs)
           {
             var topClass = attrs.setClassWhenAtTop;
             var topPadding = parseInt(attrs.paddingWhenAtTop, 10);
             var parent = element.parent();
             scope.fixed = false;
             scope.startX = $("#layout").offset().left;
             scope.startY = element.offset().top;
             scope.x = 0;
             scope.y = 0;
             
             $timeout(function() {
               scope.reconfigure();
             });

             $win.on("scroll", function () {
                scope.reconfigure();
             });

             $win.on("resize", function () {
                scope.reconfigure();
             });
             
             scope.toggleFixed = function() {
               scope.fixed = !scope.fixed;
               scope.reconfigure();
             }
             
             scope.reconfigure = function() {
               var offsetTop = element.offset().top;
               var brother = $(element.parent()[0].children[0]);
               var winHeight = brother.offset().top + brother.height();
               if (offsetTop > winHeight) {
                   //on some browsers this is slow
                   element.removeClass("ng-hide");
                   
                   if(!scope.fixed) {
                     element.removeClass(topClass);
                   } else {
                     element.addClass(topClass);
                   }
               } 
               
               scope.style = {
                   left : (!scope.fixed)? "-22px" : scope.x + "px",
                   top : (!scope.fixed)? "" : scope.y + "px",
                   position: (!scope.fixed)? "relative" : "",
                   display: (!scope.fixed)? "inline-block" : ""
                };
               
               if(scope.$root.$$phase != '$apply') {
                 scope.$apply();
               }
             }
                 
             scope.mousedown = function(event) {
               // Prevent default dragging of selected content
               event.preventDefault();
               scope.startX = event.screenX - scope.x;
               scope.startY = event.screenY - scope.y;
               $document.on('mousemove', scope.mousemove);
               $document.on('mouseup', scope.mouseup);
             }

             scope.mousemove = function(event) {
               scope.y = event.screenY - scope.startY;
               scope.x = event.screenX - scope.startX;
               scope.reconfigure();
             }

             scope.mouseup = function() {
               $document.off('mousemove', scope.mousemove);
               $document.off('mouseup', scope.mouseup);
             }
             

             $("header", element).on('mousedown', scope.mousedown);
           }
       };
   }]);
     
})();
