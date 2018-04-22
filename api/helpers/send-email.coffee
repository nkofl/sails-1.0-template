path = require 'path'

module.exports = 
  friendlyName: 'Send email'
  description: 'Send an email using a template.'
  extendedDescription: 'To ease testing and development, if the provided "to" email address ends in "@example.com",
    then the email message will be written to the terminal instead of actually being sent.
    (Thanks [@simonratner](https://github.com/simonratner)!)'
  inputs: 
    template: 
      description: 'A view under views/emails'
      example: 'reset-password'
      type: 'string'
      required: true
    data: 
      description: 'data passed to the view'
      type: {}
      defaultsTo: {}
    to:
      description: 'The email address of the primary recipient.',
      type: 'string'
      extendedDescription: 'If this is any address ending in "@example.com", then don\'t actually deliver the message.'
      example: 'foo@bar.com'
      required: true
    subject: 
      description: 'The subject of the email.'
      type: 'string'
      example: 'Password reset'
      defaultsTo: ''
  exits: 
    success: 
      outputFriendlyName: 'Email delivery report'
      outputDescription: 'A dictionary of information about what went down.'
      outputType: 
        loggedInsteadOfSending: 'boolean'

  fn: (inputs, exits) ->
    htmlEmailContents = await sails.renderView(
      path.join('emails', inputs.template),
      Object.assign({links: sails.config.email.links, baseUrl: sails.config.baseUrl}, inputs.data)
    ).intercept (err) ->
      err.message = "Could not compile view template.\n
        (Usually, this means the provided data is invalid, or missing a piece.)\n
        Details:\n #{err.message}"
      return err

    isToAddressConsideredFake = Boolean(inputs.to.match(/@example\.com$/i))
    if sails.config.environment == 'test' || sails.config.email.testMode || isToAddressConsideredFake
      sails.log "Skipped sending email, either because the \"To\" email address ended in \"@example.com\"\n
        or because the current `sails.config.environment` is set to 'test'\n
        \n
        But anyway, here is what WOULD have been sent: \n
        -=-=-=-=-=-=-=-=-=-=-=-=-= Email log =-=-=-=-=-=-=-=-=-=-=-=-=-\n
        To: #{inputs.to}\n
        Subject: #{inputs.subject}\n
        \n
        Body:\n
        #{htmlEmailContents}\n
        -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
    else 
      mailOptions =
        from: sails.config.email.from
        to: inputs.to
        subject: inputs.subject
        text: 'email requires html compatible viewer'
        html: htmlEmailContents
      try 
        result = await sails.config.email.transporter.sendMail mailOptions
        return exits.success loggedInsteadOfSending: isToAddressConsideredFake
      catch err
        return exits.error err
