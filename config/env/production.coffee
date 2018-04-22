 # Production environment settings
 #
 # This file can include shared settings for a production environment,
 # such as API keys or remote database passwords.  If you're using
 # a version control solution for your Sails app, this file will
 # be committed to your repository unless you add it to your .gitignore
 # file.  If your repository will be publicly viewable, don't add
 # any private information to this file!

module.exports = 
  datastores: 
    main: 
      database: 'app_production'
  port: 1339
    # log: 
      # level: "silent"
  session: 
    cookie: 
      # secure: true,
      maxAge: 24 * 60 * 60 * 1000  # 24 hours
  http: 
    cache: 365.25 * 24 * 60 * 60 * 1000 #One year
    trustProxy: true
