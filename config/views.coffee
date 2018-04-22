cons = require('consolidate')

module.exports.views = 
  extension: 'pug'
  layout: false
  getRenderFn: () ->
    cons.pug
