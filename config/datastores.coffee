passwords = require './passwords.json'
module.exports.datastores = 
  main: 
    adapter: 'sails-postgresql'
    host: 'localhost'
    user: passwords.db.username
    password: passwords.db.password
    database: 'app_dev'
    port: 5432
