(function() {
  goog.provide('gn_categories_controller');

  var module = angular.module('gn_categories_controller',
      []);


  /**
   * CategoriesController provides all necessary operations
   * to manage category.
   */
  module.controller('GnCategoriesController', [
    '$scope', '$routeParams', '$http', '$rootScope',
    '$translate', '$timeout',
    function($scope, $routeParams, $http, $rootScope,
             $translate, $timeout) {

      $scope.categories = null;
      $scope.categorySelected = {id: $routeParams.categoryId};

      $scope.categoryUpdated = false;

      $scope.selectCategory = function(c) {
        $scope.cateroryUpdated = false;
        $scope.categorySelected = c;
        $timeout(function() {
          $('#categoryname').focus();
        }, 100);
      };


      /**
       * Delete a category
       */
      $scope.deleteCategory = function(id) {
        var data = $.param({
            id: id
        });

        $http.post('admin.category.remove?' + data)
        .success(function(data) {
              $scope.unselectCategory();
              loadCategories();
            })
        .error(function(data) {
              $rootScope.$broadcast('StatusUpdated', {
                title: $translate.instant('categoryDeleteError'),
                error: data,
                timeout: 0,
                type: 'danger'});
            });
      };

      /**
       * Save a category
       */
      $scope.saveCategory = function(formId) {
          $http({
              method: 'POST',
              url: 'admin.category.update',
              data: $(formId).serialize(),
              headers: {'Content-Type': 'application/x-www-form-urlencoded'}
          })
          .success(function(data) {
              $scope.unselectCategory();
              loadCategories();
              $rootScope.$broadcast('StatusUpdated', {
                msg: $translate.instant('categoryUpdated'),
                timeout: 2,
                type: 'success'});
            })
          .error(function(data) {
              $rootScope.$broadcast('StatusUpdated', {
                title: $translate.instant('categoryUpdateError'),
                error: data,
                timeout: 0,
                type: 'danger'});
            });
      };

      $scope.addCategory = function() {
        $scope.unselectCategory();
        $scope.categorySelected = {
          '@id': '',
          name: ''
        };
        $timeout(function() {
          $('#categoryname').focus();
        }, 100);
      };

      $scope.unselectCategory = function() {
        $scope.categorySelected = {};
      };
      $scope.updatingCategory = function() {
        $scope.categoryUpdated = true;
      };

      function loadCategories() {
        $http.get('info@json?type=categories').success(function(data) {
          $scope.categories = data.metadatacategory;
        }).error(function(data) {
          // TODO
        });
      }
      loadCategories();
    }]);

})();
