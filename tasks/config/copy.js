/**
 * Copy files and/or folders.
 */
module.exports = function(grunt) {

  grunt.config.set('copy', {
    assets: {
      files: [{
        expand: true,
        cwd: './assets',
        src: ['**/*.!(coffee|less|scss|sass)', '!**/*.js.coffee'],
        dest: '.tmp/public'
      }]
    },
    views: {
      files: [{
        expand: true,
        cwd: './views',
        src: ['**/*'],
        dest: '.tmp/views'
      }]
    },
  });
  // grunt.loadNpmTasks('grunt-contrib-copy');
};
