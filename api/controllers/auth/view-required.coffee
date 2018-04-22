module.exports = 
  friendlyName: 'Login required'
  description: 'Display the bare login page when login is needed even for homepage'
  exits: 
    success: 
      viewTemplatePath: 'auth/required'
    redirect: 
      description: 'The requesting user is already logged in.'
      responseType: 'redirect'
  fn: (inputs, exits) ->
    if this.req.session.user
      exits.redirect '/'
    else
      exits.success()
