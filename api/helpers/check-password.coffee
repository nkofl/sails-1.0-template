bcrypt = require('bcryptjs')

module.exports =
  friendlyName: 'Password Encrypter'
  description: 'Encrypt a password using bcrypt'
  inputs: 
    password: 
      type: 'string',
      description: 'The clear-text password to compare'
      required: true
    hash: 
      type: 'string',
      description: 'The encrypted password to check against'
      required: true

  fn: (inputs, exits) ->
    result = await bcrypt.compare inputs.password, inputs.hash
    exits.success result
