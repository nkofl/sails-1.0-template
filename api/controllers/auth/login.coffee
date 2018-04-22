uuid = require 'uuid'
module.exports =
  friendlyName: 'Login'
  description: 'Log in using the provided email and password combination.'
  inputs:
    email:
      description: 'The email to log in as'
      type: 'string'
      required: true
    password:
      description: 'The unencrypted password to try'
      type: 'string'
      required: true
    rememberMe:
      description: 'Whether to extend the lifetime of the user\'s session.'
      type: 'boolean'
  exits:
    success:
      description: 'The user has been successfully logged in.'
    invalid: 
      description: 'The email and password combo is invalid'
      responseType: 'unauthorized'
    redirect: 
      description: 'Login success - redirect'
      responseType: 'redirect'
  fn: (inputs, exits) ->
    fail = =>
      if this.req.wantsJSON || this.req.isSocket
        exits.invalid()
      else 
        await sails.helpers.flash this.req, 'Login Failed', 4000, 'error'
        exits.redirect '/'
    
    user = await User.findOne email: inputs.email.toLowerCase()
    if user
      passOk = await sails.helpers.checkPassword inputs.password, user.password

      if passOk && user.emailStatus == 'confirmed'
        if inputs.rememberMe
          if this.req.isSocket
            sails.log.warn 'Received `rememberMe: true` from a virtual request, but it was ignored\n
              because a browser\'s session cookie cannot be reset over sockets.\n
              Please use a traditional HTTP request instead.'
          else
            this.req.session.cookie.maxAge = sails.config.custom.rememberMeCookieMaxAge

        this.req.session.user = user

        if this.req.wantsJSON || this.req.isSocket
          exits.success()
        else if this.req.session.returnTo
          await sails.helpers.flash this.req, 'User logged in'
          exits.redirect this.req.session.returnTo
        else 
          await sails.helpers.flash this.req, 'User logged in'
          exits.redirect '/'
      else if passOk
        token = uuid.v4()
        await User.update(id: user.id).set
          emailToken: token,
          emailExpires: new Date(Date.now() + 24*60*60*1000) # 1 day

        await sails.helpers.sendEmail.with
          to: inputs.email
          subject: 'Confirm Email'
          template: 'email-verify-account'
          data:
            firstName: user.firstName
            token: token

        if this.req.wantsJSON || this.req.isSocket
          exits.success 'Must confirm email'
        else
          await sails.helpers.flash this.req, 'Email not yet confirmed. Please check your email and click the link to activate your account', 4000
          exits.redirect '/'
      else
        fail()
    else
      fail()
