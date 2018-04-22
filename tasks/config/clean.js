/**
 * Remove generated files and folders.
 */
module.exports = function(grunt) {

  grunt.config.set('clean', {
    all: ['.tmp/public/**', '.tmp/views/**']
  });
};
