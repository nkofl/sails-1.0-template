module.exports = 
  friendlyName: 'About page'
  description: 'Display the about page'
  exits: 
    success: 
      viewTemplatePath: 'about/about'
  fn: (inputs, exits) ->
    exits.success()