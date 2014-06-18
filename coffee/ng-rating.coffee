do ->

	# module
	ngRating = angular.module 'ngRating', []

	# ng-rating directive
	ngRating.directive 'ngRating', [
			'$timeout'
		(
			$timeout
		) ->
		restrict : 'EA'
		require: 'ngModel'
		scope:
			ngModel: '='
			starsCount: '=?'
			editable: '=?'
			iconClass: '=?'
			showGrade: '=?'
			basedOn : '=?'
		template : [
			'<span class="ng-rating ng-rating--{{ levelClass }} {{ editableClass }}">'
				'<span class="ng-rating-group">'
					'<span ng-mouseover="onMouseover($index)" ng-click="set($index)" class="ng-rating-star" ng-repeat="star in stars" ng-class="{true:\'ng-rating-star--active\'}[rating>=$index || tmpValue>=$index]">'
						'<i class="{{ iconClass }}"></i>'
					'</span>'
				'</span>'
				'<span style="width: {{ width }}" class="ng-rating-group--hover">'
					'<span class="ng-rating-star--hover" ng-repeat="star in stars" ng-class="{true:\'ng-rating-star--active\'}[rating>=$index || tmpValue>=$index]">'
						'<i class="{{ iconClass }}"></i>'
					'</span>'
				'</span>'
				'<span class="ng-rating-grade" ng-if="showGrade">'
					'{{ rating }}'
				'</span>'
			'</span>'].join('')
		link: (scope, element, $attr, ngModel) ->

			# vars
			levelsClasses = ['xlow', 'low', 'medium', 'high', 'xhigh']
			scope.starsCount ?= 5
			scope.basedOn ?= 5
			scope.iconClass ?= 'fa fa-star'
			scope.stars = []
			scope.tmpValue = null
			isEditable = scope.editable isnt undefined and scope.editable isnt false
			scope.editableClass = 'ng-rating--editable' if isEditable

			# when the mouse leave, reset the temp value reset the selected value
			element.bind 'mouseleave',  () ->
				# delete the temp value
				scope.tmpValue = null
				# render the ratings
				ngModel.$render()

			# when mouse is hover, set the temp value to update the display without changing the model
			scope.onMouseover = (index) ->
				return if not isEditable
				scope.tmpValue = scope.basedOn / scope.starsCount * (index+1)
				ngModel.$render()

			# function to set a value in the model and update the display
			scope.set = (index) -> $timeout ->
				return if not isEditable

				# process with basedOn
				v = scope.basedOn / scope.starsCount * (index+1)

				ngModel.$setViewValue(v)
				ngModel.$render()

			# update the display
			ngModel.$render = -> $timeout ->

				# render with temp value or actual ngModel one :
				if scope.tmpValue then v = scope.tmpValue
				else v = ngModel.$viewValue

				# translate the value in stars world
				starsValue =  Math.round(scope.starsCount / scope.basedOn * v * 100) / 100

				# calculate the real value to put in the model
				# modelValue =  scope.starsCount / scope.basedOn * v

				# console.log 'before', scope.basedOn, scope.starsCount, v, starsValue

				# calculate color index
				index = Math.round(levelsClasses.length / scope.starsCount * starsValue);
				index = 1 if index == 0

				# set the level class
				scope.levelClass = levelsClasses[index-1]

				# update rating in scope for view
				scope.rating = starsValue

				# update width
				scope.width = starsValue * (100 / scope.starsCount) + '%'

			# create the stars
			for i in [0...scope.starsCount]
				scope.stars.push
					empty: i >= ngModel.$viewValue
					index: i+1

	]
			