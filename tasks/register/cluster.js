module.exports = function (grunt) {
  grunt.registerTask('cluster', [
    'polyfill:prod', //« Remove this to skip transpilation in production (not recommended)
    'compileAssets',
    'babel',         //« Remove this to skip transpilation in production (not recommended)
    'uglify',
    'cssmin',
    //'rename',
    'sails-linker:prodJsGlobal',
    'sails-linker:prodStylesGlobal',
    'sails-linker:prodJsViews',
    'sails-linker:prodStylesViews',
    'sails-linker:devTplJade'
  ]);
};
