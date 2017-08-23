(function() {
  goog.provide('gn_standards_controller');


  var module = angular.module('gn_standards_controller',
      []);


  /**
   * GnStandardsController provides administration tools
   * for standards.
   *
   * TODO: More testing required on add/update action
   *
   */
  module.controller('GnStandardsController', [
    '$scope', '$routeParams', '$http', '$rootScope', '$translate', '$compile',
    'gnSearchManagerService',
    'gnUtilityService',
    function($scope, $routeParams, $http, $rootScope, $translate, $compile,
            gnSearchManagerService,
            gnUtilityService) {

      $scope.pageMenu = {
        folder: 'standards/',
        defaultTab: 'standards',
        tabs: []
      };

      $scope.schemas = [];

      function loadSchemas() {
        $http.get('admin.schema.list@json').success(function(data) {
          for (var i = 0; i < data.length; i++) {
            $scope.schemas.push({id: data[i]['#text'].trim(), props: data[i]});
          }
          $scope.schemas.sort();
        });
      }

      $scope.addStandard = function(formId, action) {
          $http({
              method: 'POST',
              url: 'admin.schema.' + action,
              data: $(formId).serialize(),
              headers: {'Content-Type': 'application/x-www-form-urlencoded'}
          })
          .success(function(data) {
              loadSchemas();
              $rootScope.$broadcast('StatusUpdated', {
                msg: $translate.instant('standardAdded'),
                timeout: 2,
                type: 'success'});
            })
          .error(function(data) {
              $rootScope.$broadcast('StatusUpdated', {
                title: $translate.instant('standardAddError'),
                error: data,
                timeout: 0,
                type: 'danger'});
            });
      };

      $scope.removeStandard = function(s) {
          var data = $.param({
              schema: s,
              "_content_type": "json"
          });

          $http.post('admin.schema.remove?' + data)
          .success(function(data) {
              if (data['@status'] === 'error') {
                $rootScope.$broadcast('StatusUpdated', {
                  title: $translate.instant('standardsDeleteError'),
                  msg: data['@message'],
                  timeout: 0,
                  type: 'danger'});
              } else {
                loadSchemas();
              }
            })
          .error(function(data) {
              $rootScope.$broadcast('StatusUpdated', {
                title: $translate.instant('standardsDeleteError'),
                error: data,
                timeout: 0,
                type: 'danger'});
            });
      };

      loadSchemas();

    }]);

})();
