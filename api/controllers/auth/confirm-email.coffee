module.exports =
  friendlyName: 'Confirm email'
  description: 'Confirm an email address for new or edited users'
  inputs: 
    token: 
      description: 'The confirmation token from the email.'
      example: '4-32fad81jdaf$329'
  exits:
    success:
      description: 'Email address confirmed'
    redirect: 
      description: 'Email address confirmed'
      responseType: 'redirect'
    invalidOrExpiredToken:
      responseType: 'expired'
      description: 'The provided token is invalid or expired'
    emailAddressNoLongerAvailable: 
      statusCode: 409
      viewTemplatePath: '500'
      description: 'The email address is no longer available.'
    emailChangeAborted:
      statusCode: 500
      viewTemplatePath: '500'
      description: 'The new candidate email address is missing or the change request was cancelled.'
  fn: (inputs, exits) ->
    if !inputs.token
      sails.log.warn 'Attempting to confirm email, but no reset password token included in request!  Displaying error page...'
      return exits.invalidOrExpiredToken 'Bad Token'

    user = await User.findOne emailToken: inputs.token
    if !user || user.emailExpires <= (new Date())
      return exits.invalidOrExpiredToken 'Bad Token'

    if user.emailStatus == 'unconfirmed'
      updatedUser = await User.update( id: user.id ).set
        emailStatus: 'confirmed'
        emailToken: ''
        emailExpires: null
      .fetch()
      if updatedUser? && updatedUser.length > 0
        user = updatedUser[0]
    else if user.emailStatus == 'changeRequested' && user.emailChangeCandidate
      if await User.count( emailAddress: user.emailChangeCandidate ) > 0
        if this.req.wantsJSON || this.req.isSocket
          return exits.emailAddressNoLongerAvailable()
        else 
          await sails.helpers.flash this.req, 'Email address no longer available'
          return exits.redirect '/'
      updatedUser = await User.update({ id: user.id }).set
        emailStatus: 'confirmed'
        emailToken: ''
        emailExpires: null
        email: user.emailChangeCandidate
        emailChangeCandidate: ''
      .fetch()
    else
      updatedUser = null
    if updatedUser? && updatedUser.length > 0
      this.req.session.user = updatedUser[0]
    if this.req.wantsJSON || this.req.isSocket
      exits.success()
    else 
      await sails.helpers.flash this.req, 'Email address confirmed'
      exits.redirect '/'

