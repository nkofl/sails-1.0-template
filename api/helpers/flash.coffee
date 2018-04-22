module.exports =
  friendlyName: 'Flash message displayer'
  description: 'Stuff a flash message with a type and delay onto the session'
  inputs: 
    req: 
      type: 'ref',
      description: 'The current incoming request (req).'
      required: true
    message: 
      type: 'string'
      example: 'User created successfully'
      description: 'The message text to display'
      required: true
    delay:
      type: 'number'
      example: 3000
      description: 'the number of milliseconds for which the message should be displayed'
    kind: 
      type: 'string'
      example: 'update'
      description: 'the type of message: update, error'
  fn: (inputs, exits) ->
    inputs.req.session.flash = 
      message: inputs.message
      clearDelay: inputs.delay || 3000
      kind: inputs.kind || 'update'
    exits.success()
