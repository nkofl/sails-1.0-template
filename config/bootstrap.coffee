module.exports.bootstrap = (cb) ->
  sails.colors = require('colors/safe')
  # load all modules *Bootstrap.js in bootstrap directory
  # and execute async
  options = 
    dirname: __dirname + '/../bootstrap'
    filter: /(.+)\.coffee$/
    optional: true
  async.each(_.values(require('include-all')(options)), (bootmodule, callback) ->
    if _.isFunction(bootmodule) 
      bootmodule(callback)
    else
      callback()
  , cb)

