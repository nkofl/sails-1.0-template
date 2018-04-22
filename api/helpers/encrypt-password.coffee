bcrypt = require('bcryptjs')

module.exports =
  friendlyName: 'Password Encrypter'
  description: 'Encrypt a password using bcrypt'
  inputs: 
    password: 
      type: 'string',
      description: 'The password to encrypt'
      required: true
  fn: (inputs, exits) ->
    exits.success await bcrypt.hash inputs.password, 10
