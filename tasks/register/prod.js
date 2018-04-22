/**
 * Since production mode might start multiple instances, grunt tasks are not run here. Put them in cluster.js instead,
 * which will be called explicitly once
 */
module.exports = function(grunt) {
  grunt.registerTask('prod', [
  ]);
};

