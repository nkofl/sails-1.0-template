/**
 * grunt/pipeline.js
 *
 * The order in which your css, javascript, and template files should be
 * compiled and linked from your views and static HTML files.
 *
 * (Note that you can take advantage of Grunt-style wildcard/glob/splat expressions
 * for matching multiple files, and ! in front of an expression to ignore files.)
 *
 * For more information see:
 *   https://github.com/balderdashy/sails-docs/blob/master/anatomy/myApp/tasks/pipeline.js.md
 */

const path = require('path');
var fs = require('fs');
var tmpPath = '.tmp/public/';
var viewRoot = 'views';
var jsRoot = 'assets/js/views';
var cssRoot = 'assets/styles/views';
var viewOut = '.tmp/views';
var jsOut = path.join(tmpPath, 'js/views');
var cssOut = path.join(tmpPath, 'styles/views');
var globalName = 'app';

// CSS files to inject in order
//
// (if you're using LESS with the built-in default config, you'll want
//  to change `assets/styles/importer.less` instead.)
var globalCssToInject = [
  'styles/dependencies/' + globalName + '.css'
];

var globalJsToInject = [
  'js/dependencies/sails.io.js',
  'js/dependencies/jquery-3.3.1.js',
  'js/dependencies/**/*.js',
];

var transformPath = function(assetPath) {
  // If we're ignoring the file, make sure the ! is at the beginning of the path
  if (assetPath[0] === '!') {
    return '!' + tmpPath + assetPath.substr(1);
  }
  return tmpPath + assetPath;
}

var findCss = (dir) => {
  var results = [];
  try {
    fs.readdirSync(path.join(cssRoot,dir)).forEach(file => {
      var filePath = path.join(dir, file);
      var fullPath = path.join(cssRoot, filePath);
      if((filePath.endsWith('.css') || filePath.endsWith('.scss')) && !file.startsWith('_') && fs.statSync(fullPath).isFile()){
        if(filePath.endsWith('.scss'))
          filePath = filePath.substr(0,filePath.length - 4) + 'css';
        results.push(path.join(cssOut, filePath));    
      }
    });
  } catch(err) {
  }
  return results;
}

var findJs = (dir) => {
  var results = [];
  try {
    fs.readdirSync(path.join(jsRoot,dir)).forEach(file => {
      var filePath = path.join(dir, file);
      var fullPath = path.join(jsRoot, filePath);
      if((filePath.endsWith('.js') || filePath.endsWith('.coffee')) && fs.statSync(fullPath).isFile()){
        if(filePath.endsWith('.coffee'))
          filePath = filePath.substr(0,filePath.length - 7);
          if(!filePath.endsWith('.js'))
            filePath = filePath + '.js';
        results.push(path.join(jsOut, filePath));    
      }
    });
  } catch(err) {
  }
  return results;
}

var findViews = (dir, results) => {
  results = results || [];
  fs.readdirSync(path.join(viewRoot,dir)).forEach(file => {
    var viewPath = path.join(dir, file)
    var fullPath = path.join(viewRoot, viewPath)
    if(fs.statSync(fullPath).isDirectory()){
      results = findViews(viewPath, results);
    } else if(file.endsWith('.pug')){
      var filePath = viewPath.substr(0,viewPath.length - 4);
      var js = findJs(filePath);
      var css = findCss(filePath);
      var minJs = '';
      var minCss = '';
      if(js.length > 0)
        minJs = path.join(jsOut, filePath + '.min.js');
      if(css.length > 0)
        minCss = path.join(cssOut, filePath + '.min.css');
      results.push({
        view: path.join(viewOut, viewPath),
        js: js,
        minJs: minJs,
        css: css,
        minCss: minCss
      });
    }
  });
  return results;
}
var perPageInjection = findViews('');

var uglifyFiles = perPageInjection.reduce((result, view) =>{
  if(view.minJs != ''){
    result[view.minJs] = view.js;
  }
  return result;
}, {});
uglifyFiles[path.join(tmpPath, 'js', globalName + '.min.js')] = globalJsToInject.map(transformPath)

var cssMinFiles = perPageInjection.reduce((result, view) =>{
  if(view.minCss != ''){
    result[view.minCss] = view.css;
  }
  return result;
}, {});
cssMinFiles[path.join(tmpPath, 'styles', globalName + '.min.css')] = globalCssToInject.map(transformPath)


var injection = {
  dev: {
    global: {
      js: {},
      css: {}
    },
    views: {
      js: 
        perPageInjection.reduce((result, view) =>{
          if(view.js.length > 0){
            result[view.view] = view.js;
          }
          return result;
        }, {}),
      css: 
        perPageInjection.reduce((result, view) =>{
          if(view.css.length > 0){
            result[view.view] = view.css;
          }
          return result;
        }, {})
    }
  },
  prod: {
    global: {
      js: {},
      css: {}
    },
    views: {
      js:
        perPageInjection.reduce((result, view) =>{
          if(view.js.length > 0){
            result[view.view] = view.minJs;
          }
          return result;
        }, {}),
      css:
        perPageInjection.reduce((result, view) =>{
          if(view.css.length > 0){
            result[view.view] = view.minCss;
          }
          return result;
        }, {})
    }
  }
}
var all = path.join(viewOut, '**/*.pug');
injection.dev.global.js[all] = globalJsToInject.map(transformPath);
injection.dev.global.css[all] = globalCssToInject.map(transformPath);
injection.prod.global.js[all] = path.join(tmpPath, 'js', globalName + '.min.js');
injection.prod.global.css[all] = path.join(tmpPath, 'styles', globalName + '.min.css');



// Client-side HTML templates are injected using the sources below
// The ordering of these templates shouldn't matter.
// (uses Grunt-style wildcard/glob/splat expressions)
//
// By default, Sails uses JST templates and precompiles them into
// functions for you.  If you want to use jade, handlebars, dust, etc.,
// with the linker, no problem-- you'll just want to make sure the precompiled
// templates get spit out to the same file.  Be sure and check out `tasks/README.md`
// for information on customizing and installing new tasks.
var templateFilesToInject = [
  'templates/**/*.html'
];



// Prefix relative paths to source files so they point to the proper locations
// (i.e. where the other Grunt tasks spit them out, or in some cases, where
// they reside in the first place)
module.exports.injection = injection;
module.exports.templateFilesToInject = templateFilesToInject.map(transformPath);
module.exports.cssMinFiles = cssMinFiles;
module.exports.uglifyFiles = uglifyFiles;
