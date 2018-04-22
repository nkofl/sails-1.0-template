/**
 * default and watch use this
 */
module.exports = function(grunt) {
  grunt.registerTask('linkAssets', [
    'sails-linker:devJsGlobal',
    'sails-linker:devStylesGlobal',
    'sails-linker:devJsViews',
    'sails-linker:devStylesViews',
    'sails-linker:devTplJade'
  ]);
};
