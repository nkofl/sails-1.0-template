module.exports = 
  friendlyName: 'Show homepage'
  description: 'Display the homepage.'
  exits: 
    success: 
      viewTemplatePath: 'homepage/show',
  fn: (inputs, exits) ->
    exits.success()
