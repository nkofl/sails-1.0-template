/**
 * Automatically inject <script> tags and <link> tags into the specified
 * specified HTML and/or EJS files.  The specified delimiters (`startTag`
 * and `endTag`) determine the insertion points.
 */
module.exports = function(grunt) {
  grunt.config.set('sails-linker', {
    devJsGlobal: {
      options: {
        startTag: '// SCRIPTS',
        endTag: '// SCRIPTS END',
        fileTmpl: 'script(src="%s")',
        appRoot: '.tmp/public'
      },
      files: require('../pipeline').injection.dev.global.js
    },

    prodJsGlobal: {
      options: {
        startTag: '// SCRIPTS',
        endTag: '// SCRIPTS END',
        fileTmpl: 'script(src="%s")',
        appRoot: '.tmp/public'
      },
      files: require('../pipeline').injection.prod.global.js
    },

    devStylesGlobal: {
      options: {
        startTag: '// STYLES',
        endTag: '// STYLES END',
        fileTmpl: 'link(rel="stylesheet", href="%s")',
        appRoot: '.tmp/public'
      },
      files: require('../pipeline').injection.dev.global.css
    },

    prodStylesGlobal: {
      options: {
        startTag: '// STYLES',
        endTag: '// STYLES END',
        fileTmpl: 'link(rel="stylesheet", href="%s")',
        appRoot: '.tmp/public'
      },
      files: require('../pipeline').injection.prod.global.css
    },
    devJsViews: {
      options: {
        startTag: '// VIEW SCRIPTS',
        endTag: '// VIEW SCRIPTS END',
        fileTmpl: 'script(src="%s")',
        appRoot: '.tmp/public'
      },
      files: require('../pipeline').injection.dev.views.js
    },

    prodJsViews: {
      options: {
        startTag: '// VIEW SCRIPTS',
        endTag: '// VIEW SCRIPTS END',
        fileTmpl: 'script(src="%s")',
        appRoot: '.tmp/public'
      },
      files: require('../pipeline').injection.prod.views.js
    },

    devStylesViews: {
      options: {
        startTag: '// VIEW STYLES',
        endTag: '// VIEW STYLES END',
        fileTmpl: 'link(rel="stylesheet", href="%s")',
        appRoot: '.tmp/public'
      },
      files: require('../pipeline').injection.dev.views.css
    },

    prodStylesViews: {
      options: {
        startTag: '// VIEW STYLES',
        endTag: '// VIEW STYLES END',
        fileTmpl: 'link(rel="stylesheet", href="%s")',
        appRoot: '.tmp/public'
      },
      files: require('../pipeline').injection.prod.views.css
    },

    // Bring in JST template object
    devTplJade: {
      options: {
        startTag: '// TEMPLATES',
        endTag: '// TEMPLATES END',
        fileTmpl: 'script(type="text/javascript", src="%s")',
        appRoot: '.tmp/public'
      },
      files: {
        '.tmp/views/**/*.pug': ['.tmp/public/jst.js']
      }
    }
  });//</ grunt.config.set() >

  // grunt.loadNpmTasks('grunt-sails-linker');
};
