module.exports = 
  friendlyName: 'New password after recovery'
  description: 'Display "New password" page.'
  inputs: 
    token: 
      description: 'The password reset token from the email.'
      type: 'string'
  exits:
    success:
      viewTemplatePath: 'auth/new-password'
    invalidOrExpiredToken:
      statusCode: 498
      description: 'The provided token is expired, invalid, or has already been used.'
  fn: (inputs, exits) ->
    if !inputs.token
      sails.log.warn 'Attempting to view new password (recovery) page, but no reset password token included in request!  Displaying error page...'
      exits.invalidOrExpiredToken 'Bad Token'
    user = await User.findOne resetToken: inputs.token
    if !user || user.resetExpires <= (new Date())
      exits.invalidOrExpiredToken 'Bad Token'
    this.req.session.user = user
    exits.success email: user.email
