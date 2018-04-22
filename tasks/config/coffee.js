/**
 * Compile CoffeeScript files located in `assets/js` into Javascript
 * and generate new `.js` files in `.tmp/public/js`.
 */
module.exports = function(grunt) {

  grunt.config.set('coffee', {
    all: {
      options: {
        bare: true,
        sourceMap: false,
        sourceRoot: './'
      },
      files: [{
        expand: true,
        cwd: 'assets/js/',
        src: ['**/*.coffee'],
        dest: '.tmp/public/js/',
        ext: '.js'
      }]
    }
  });
  //grunt.loadNpmTasks('grunt-contrib-coffee');
};
