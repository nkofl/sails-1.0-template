module.exports = 
  friendlyName: 'Log out'
  description: 'Log out the current user'
  exits: 
    success:
      description: 'The requesting user has been logged out.'
    redirect: 
      description: 'The requesting user has been logged out - redirect.'
      responseType: 'redirect'
  fn: (inputs, exits) ->
    delete this.req.session.user
    if this.req.wantsJSON || this.req.isSocket
      exits.success()
    else 
      await sails.helpers.flash this.req, 'User logged out'
      exits.redirect '/'
      
