module.exports = 
  friendlyName: 'User Registration'
  description: 'Display the new user registration page'
  exits: 
    success: 
      viewTemplatePath: 'auth/register'
    redirect: 
      description: 'The requesting user is already logged in.'
      responseType: 'redirect'
  fn: (inputs, exits) ->
    if this.req.session.user
      exits.redirect '/'
    else
      exits.success()
