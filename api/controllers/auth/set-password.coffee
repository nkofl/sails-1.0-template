module.exports = 
  friendlyName: 'Set new password'
  description: 'Set a new password after recovery'
  inputs:
    password: 
      description: 'unencrypted password'
      type: 'string'
      required: true
  exits: 
    success:
      description: 'Your password has been updated.'
    redirect: 
      description: 'Your password has been updated'
      responseType: 'redirect'
  fn: (inputs, exits) ->
    try
      updatedUser = await User.update( id: this.req.session.user.id ).set
        password: inputs.password
        resetToken: ''
        resetExpires: null
      .fetch()
      if updatedUser? && updatedUser.length > 0
        this.req.session.user = updatedUser[0]
      if this.req.wantsJSON || this.req.isSocket
        exits.success()
      else 
        await sails.helpers.flash this.req, 'Password updated'
        exits.redirect '/'
    catch err
      if this.req.wantsJSON || this.req.isSocket
        exits.error err
      else 
        await sails.helpers.flash this.req, 'Password update failed', 3000, 'error'
        exits.redirect '/'