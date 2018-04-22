/**
 * Synchronize files from the `assets` folder to `.tmp/public`,
 * smashing anything that's already there.
 */
module.exports = function(grunt) {

  grunt.config.set('sync', {
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
    }
  });

  // grunt.loadNpmTasks('grunt-sync');
};
