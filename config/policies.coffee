 # Policy Mappings
 # (sails.config.policies)
 #
 # Policies are simple functions which run **before** your controllers.
 # You can apply one or more policies to a given controller, or protect
 # its actions individually.
 #
 # Any policy file (e.g. `api/policies/authenticated.js`) can be accessed
 # below by its filename, minus the extension, (e.g. "authenticated")
 #
 # For more information on how policies work, see:
 # http://sailsjs.org/#!/documentation/concepts/Policies
 #
 # For more information on configuring policies, check out:
 # http://sailsjs.org/#!/documentation/reference/sails.config/sails.config.policies.html

#for public sites
siteDefault = ['clear-redirect']
#for private sites
#siteDefault = ['clear-redirect', 'is-logged-in']

module.exports.policies = 
  '*': false
  'about': 
    'view-about': siteDefault
    'view-contact': siteDefault
  'auth': 
    'confirm-email': true
    'login': true
    'logout': true
    'new-user': true
    'send-reset-email': true
    'set-password': ['clear-redirect', 'is-logged-in']
    'view-forgot-password': true
    'view-new-password': true
    'view-register': true
    'view-required': true
  'homepage': 
    'view-show': siteDefault
  'user':
    'view-profile': ['clear-redirect', 'is-logged-in']
