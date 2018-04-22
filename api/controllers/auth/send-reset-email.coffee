uuid = require 'uuid'
module.exports =
  friendlyName: 'Send password recovery email'
  description: 'Send a password recovery message to the specified email address.'
  inputs:
    email:
      description: 'The email address of the alleged user who wants to recover their password.'
      type: 'string'
      required: true
  exits:
    success:
      description: 'Recovery email sent'
    redirect: 
      description: 'email sent - redirect'
      responseType: 'redirect'
    error:
      description: 'Internal server error'
      statusCode: 500
  fn: (inputs, exits) ->
    try
      user = await User.findOne email: inputs.email
      if user
        token = uuid.v4()
        await User.update(id: user.id).set
          resetToken: token,
          resetExpires: new Date(Date.now() + 1*60*60*1000) # 1 hour

        await sails.helpers.sendEmail.with
          to: inputs.email
          subject: 'Password Reset'
          template: 'email-reset-password'
          data:
            firstName: user.firstName
            token: token
      if this.req.wantsJSON || this.req.isSocket
        exits.success 'sent'
      else
        await sails.helpers.flash this.req, 'Password reset email sent. Please check your email and click the link to change your password', 4000
        exits.redirect '/'
    catch err
      exits.error err
