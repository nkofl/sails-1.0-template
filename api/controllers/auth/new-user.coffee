uuid = require 'uuid'
module.exports = 
  friendlyName: 'Create new user'
  description: 'Create a new user account'
  inputs:
    email:
      description: 'email address'
      type: 'string'
      required: true
    firstName:
      description: 'first name'
      type: 'string'
      required: true
    lastName: 
      description: 'last name'
      type: 'string'
      required: true
    company: 
      description: 'company name'
      type: 'string'
      required: true
    mobilePhone:
      description: 'mobile phone number'
      type: 'string'
      required: true
    directPhone:
      description: 'direct phone number'
      type: 'string'
      required: true
    address:
      description: 'address'
      type: 'string'
      required: true
    city:
      description: 'city'
      type: 'string'
      required: true
    state:
      description: 'state'
      type: 'string'
      required: true
    zip: 
      description: 'zip'
      type: 'string'
      required: true
    userType: 
      description: 'user type: client or expert'
      type: 'string'
      required: false
    password: 
      description: 'unencrypted password'
      type: 'string'
      required: true
  exits: 
    success:
      description: 'The user has been successfully created.'
    emailTaken: 
      description: 'The email address was already used'
      responseType: 'redirect'
    redirect: 
      description: 'Created successfully - redirect'
      responseType: 'redirect'
  fn: (inputs, exits) ->
    try
      user = await User.findOne { email: inputs.email }
      if user?
        await sails.helpers.flash this.req, 'Email Address Already Taken', 4000, 'error'
        exits.emailTaken '/auth/register'
      else
        token = uuid.v4()
        id = uuid.v4()
        await User.create
          id: id
          email: inputs.email
          firstName: inputs.firstName
          lastName: inputs.lastName
          company: inputs.company
          mobilePhone: inputs.mobilePhone
          directPhone: inputs.directPhone
          address: inputs.address
          city: inputs.city
          state: inputs.state
          zip: inputs.zip
          userType: inputs.userType
          password: inputs.password
          emailToken: token
          emailExpires: new Date(Date.now() + 24*60*60*1000) # 1 day
      
        await sails.helpers.sendEmail.with
          to: inputs.email
          subject: 'Confirm Email'
          template: 'email-verify-account'
          data:
            firstName: inputs.firstName
            token: token

        if this.req.wantsJSON || this.req.isSocket
          exits.success 'Signup successful!'
        else
          await sails.helpers.flash this.req, 'User created. Please check your email and click the link to activate your account', 4000
          exits.redirect '/'
    catch err
      exits.error err
