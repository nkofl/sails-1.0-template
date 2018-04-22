module.exports = 
  friendlyName: 'Contact page'
  description: 'Display the contact page'
  exits: 
    success: 
      viewTemplatePath: 'about/contact'
  fn: (inputs, exits) ->
    exits.success()