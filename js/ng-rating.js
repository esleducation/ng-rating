(function() {
  var ngRating;
  ngRating = angular.module('ngRating', []);
  return ngRating.directive('ngRating', [
    '$timeout', function($timeout) {
      return {
        restrict: 'EA',
        require: 'ngModel',
        scope: {
          ngModel: '=',
          starsCount: '=?',
          editable: '=?',
          iconClass: '=?',
          showGrade: '=?',
          basedOn: '=?'
        },
        template: ['<span class="ng-rating ng-rating--{{ levelClass }} {{ editableClass }}">', '<span class="ng-rating-group">', '<span ng-mouseover="onMouseover($index)" ng-click="set($index)" class="ng-rating-star" ng-repeat="star in stars" ng-class="{true:\'ng-rating-star--active\'}[rating>=$index || tmpValue>=$index]">', '<i class="{{ iconClass }}"></i>', '</span>', '</span>', '<span style="width: {{ width }}" class="ng-rating-group--hover">', '<span class="ng-rating-star--hover" ng-repeat="star in stars" ng-class="{true:\'ng-rating-star--active\'}[rating>=$index || tmpValue>=$index]">', '<i class="{{ iconClass }}"></i>', '</span>', '</span>', '<span class="ng-rating-grade" ng-if="showGrade">', '{{ rating }}', '</span>', '</span>'].join(''),
        link: function(scope, element, $attr, ngModel) {
          var i, isEditable, levelsClasses, _i, _ref, _results;
          levelsClasses = ['xlow', 'low', 'medium', 'high', 'xhigh'];
          if (scope.starsCount == null) {
            scope.starsCount = 5;
          }
          if (scope.basedOn == null) {
            scope.basedOn = 5;
          }
          if (scope.iconClass == null) {
            scope.iconClass = 'fa fa-star';
          }
          scope.stars = [];
          scope.tmpValue = null;
          isEditable = scope.editable !== void 0 && scope.editable !== false;
          if (isEditable) {
            scope.editableClass = 'ng-rating--editable';
          }
          element.bind('mouseleave', function() {
            scope.tmpValue = null;
            return ngModel.$render();
          });
          scope.onMouseover = function(index) {
            if (!isEditable) {
              return;
            }
            scope.tmpValue = scope.basedOn / scope.starsCount * (index + 1);
            return ngModel.$render();
          };
          scope.set = function(index) {
            return $timeout(function() {
              var v;
              if (!isEditable) {
                return;
              }
              v = scope.basedOn / scope.starsCount * (index + 1);
              ngModel.$setViewValue(v);
              return ngModel.$render();
            });
          };
          ngModel.$render = function() {
            return $timeout(function() {
              var index, starsValue, v;
              if (scope.tmpValue) {
                v = scope.tmpValue;
              } else {
                v = ngModel.$viewValue;
              }
              starsValue = Math.round(scope.starsCount / scope.basedOn * v * 100) / 100;
              index = Math.round(levelsClasses.length / scope.starsCount * starsValue);
              if (index === 0) {
                index = 1;
              }
              scope.levelClass = levelsClasses[index - 1];
              scope.rating = starsValue;
              return scope.width = starsValue * (100 / scope.starsCount) + '%';
            });
          };
          _results = [];
          for (i = _i = 0, _ref = scope.starsCount; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
            _results.push(scope.stars.push({
              empty: i >= ngModel.$viewValue,
              index: i + 1
            }));
          }
          return _results;
        }
      };
    }
  ]);
})();
