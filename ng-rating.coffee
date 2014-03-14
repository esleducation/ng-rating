directives = angular.module 'eslNgRating', []

directives.directive 'starRating', () ->
	restrict : 'EA'
	template : '
		<span class=stars-group>
			<span class="star-rating" ng-repeat="star in stars" ng-class="{true: \'star-empty\', false: \'star\'}[star.empty]"><i class="fa fa-star"></i></span>
		</span>
		<span style="color: #{{ color }}; width: {{ width }}" class="stars-group--hover">
			<span class="star-rating--hover" ng-repeat="star in stars" ng-class="{true: \'star-empty\', false: \'star\'}[star.empty]"><i class="fa fa-star"></i></span>
		</span>
		<span class="grade" ng-if="showGrade">{{ value }}</span>'
	link: (scope, element, $attr) ->
		scope.$watch 'value', (val, newVal) ->
			if val isnt undefined
				value = Math.round scope.value
				scope.maxRating ?= 5
				scope.showGrade = if $attr.showGrade isnt undefined then true else false
				scope.stars = []
				scope.color = ['e11e21', 'ff5d10','e8800e','f9b836','fdd119'][value - 1]
				scope.width = scope.value * 20 +'%'

				for i in [0...scope.maxRating]
					scope.stars.push
						empty: i >= value
						index: i+1 
			return
		return;
	scope:
		value: '='
		maxRating: '=?'