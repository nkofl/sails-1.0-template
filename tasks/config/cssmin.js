/**
 * Together with the `concat` task, this is the final step that minifies
 * all CSS files from `assets/styles/` (and potentially your LESS importer
 * file from `assets/styles/importer.less`)
 */
module.exports = function(grunt) {
  grunt.config.set('cssmin', {
    all: {
      files: require('../pipeline').cssMinFiles
    }
  });
  // grunt.loadNpmTasks('grunt-contrib-cssmin');
};
