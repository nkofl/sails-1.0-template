/**
 * Minify client-side JavaScript files using UglifyES.
 */
module.exports = function(grunt) {

  grunt.config.set('uglify', {
    all: {
      files: require('../pipeline').uglifyFiles
    },
    options: {
      mangle: {
        reserved: [
          'AsyncFunction',
          'SailsSocket',
          'Promise',
          'File',
          'Location',
          'RttcRefPlaceholder',
        ],
        keep_fnames: true//eslint-disable-line
      },
      compress: {
        keep_fnames: true//eslint-disable-line
      }
    }
  });

  // grunt.loadNpmTasks('grunt-contrib-uglify');
};

