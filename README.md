# ng-rating


Angular directive to display "stars" (or something else) based ratings


## Get Started

First, you need to include the scripts and css in your page

```markdown
<link href="ng-rating.css" rel="styletheet" type="text/css" />
<!-- optional font-awesome to have access to icons -->
<link href="font-awesome.css" rel="styletheet" type="text/css" />

<script src="angular.js"></script>
<script src="ng-rating.js"></script>
```

Then you have to specify the "ngRating" module as dependency of your angular app

```javascript
var myApp = angular.module('myAwesomeApp', ['ngRating']);
```

Finaly you can use the ng-rating directive to display ratings like so

```markdown
<ng-rating ng-model="hotel.rating"></ng-rating>
```

> See the index.html file for full sample


## Attributes

The directive accept different attributes :

* __ng-model__      : __REQUIRED__ : specify the actual rating value
* __start-count__   : the number of stars to display (default : 5)
* __based-on__      : the value on witch the calculation will be made. 5 stars based on 100 mean 1 active star = 20, etc...
* __editable__      : specify if the user can change the rating by clicking on the stars
* __icon-class__    : specify the class that will specify with icon to display for each stars (by default : fa fa-star)
* __show-grade__    : specify if the grade (rating number) is displayed or not after the stars



## Classes

These are the diferent classes that are applied

* __ng-rating__                     : The container
    * __ng-rating--xlow__               : Applied on the container when the rating level is extra-low
    * __ng-rating--low__                : Applied on the container when the rating level is low
    * __ng-rating--medium__             : Applied on the container when the rating level is medium
    * __ng-rating--high__               : Applied on the container when the rating level is high
    * __ng-rating--xhigh__              : Applied on the container when the rating level is exta-high
    * __ng-rating--editable__           : Applied on the container when the rating is editable
* __ng-rating-group__               : The group of stars
    * __ng-rating-group--hover__    : The group of stars that will be active (the width of this element will be set by the directive)
* __ng-rating-star__                : The star that contain a "i" tag
    * __ng-rating-star--active__        : Applies on the stars that are active