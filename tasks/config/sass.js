module.exports = function(grunt) {

	grunt.config.set('sass', {
		all: {
      files: [{
        expand: true,
        cwd: 'assets/styles/',
        src: ['**/*.scss'],
        dest: '.tmp/public/styles/',
        ext: '.css'
      }]
		}
	});

	grunt.loadNpmTasks('grunt-sass');
};