module.exports = 
  friendlyName: 'User profile'
  description: 'Display the user profile page'
  exits: 
    success: 
      viewTemplatePath: 'user/profile'
    redirect: 
      description: 'No user logged in.'
      responseType: 'redirect'
  fn: (inputs, exits) ->
    if this.req.session.user
      exits.success()
    else
      exits.redirect '/'
