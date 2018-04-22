module.exports = (cb) ->
  sails.config.paths.views = "#{sails.config.appPath}/.tmp/views"
  sails.hooks.http.app.set 'views', sails.config.paths.views
  cb()
