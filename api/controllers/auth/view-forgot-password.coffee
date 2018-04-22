module.exports = 
  friendlyName: 'Forgot password'
  description: 'Display "Forgot password" page.'
  exits:
    success: 
      viewTemplatePath: 'auth/forgot-password'
    redirect: 
      description: 'Already logged in.'
      responseType: 'redirect'
  fn: (inputs, exits) ->
    if this.req.session.user
      exits.redirect '/'
    else
      exits.success()
