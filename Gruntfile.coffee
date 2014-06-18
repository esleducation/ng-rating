module.exports = (grunt) ->

	paths =
		compass:
			files: '**/*.scss'
			src: 'sass'
			dest: 'css'
		coffee:
			cwd: 'coffee'
			src: '**/*.coffee'
			dest: 'js'

	# Configuration
	# =============
	grunt.initConfig
		
		pkg: grunt.file.readJSON 'package.json'

		compass:
			options:
				sassDir: paths.compass.src
				cssDir: paths.compass.dest
			development:
				options:
					environment: 'development'
					outputStyle: 'nested'
			production:
				options:
					environment: 'production'
					outputStyle: 'compressed'

		coffee:
			options: 
				bare: true
				sourceMap : false
			dist:
				files: [
					expand: true
					cwd: paths.coffee.cwd
					src: paths.coffee.src
					dest: paths.coffee.dest
					ext: '.js'
				]

		watch:
			livereload:
				options:
					livereload: 1112
				files: [
					'*.css'
					'*.js'
					'*.html'
					'**/*.php'
				]
			compass:
				files: paths.compass.files
				tasks: ['compass:development', 'notify:compass']
			coffee:
				files: paths.coffee.cwd+'/'+paths.coffee.src
				tasks: ['coffee', 'notify:coffee']
			

		notify:
			default:
				options:
					title:'Grunt'
					message: 'All tasks where processed'
			compass:
				options:
					title:'Grunt watcher'
					message: 'SASS files where processed'
			coffee:
				options:
					title:'Grunt watcher'
					message: 'Coffee files where processed'


	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-compass'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-notify'


	grunt.registerTask 'default', [
		'compass:development'
	 	'coffee'
		'notify:default'
	]