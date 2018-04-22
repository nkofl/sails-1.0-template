/**
 * used by default and cluster
 */

module.exports = function(grunt) {
  grunt.registerTask('compileAssets', [
    'clean:all',
    'jst:all',
    'sass',
    'copy:assets',
    'copy:views',
    'coffee:all'
  ]);
};
