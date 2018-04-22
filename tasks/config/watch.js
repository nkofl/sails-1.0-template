/**
 * `tasks/config/watch`
 *
 * ---------------------------------------------------------------
 *
 * Run predefined tasks whenever certain files are added, changed or deleted.
 *
 * For more information, see:
 *   https://sailsjs.com/anatomy/tasks/config/watch.js
 *
 */
module.exports = function(grunt) {

  grunt.config.set('watch', {
    assets: {

      // Assets to watch:
      files: [
        'assets/**/*',
        'tasks/pipeline.js',
        '!**/node_modules/**',
        'views/**/*'
      ],

      // When assets are changed:
      tasks: [
        'syncAssets',
        'linkAssets'
      ]
    }
  });

  // grunt.loadNpmTasks('grunt-contrib-watch');
};
