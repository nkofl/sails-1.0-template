passwords = require './passwords.json'
module.exports.session = 
  secret: passwords.session
  # cookie: {
  #   // Cookie expiration in milliseconds.
  #   // For example, use 24 * 60 * 60 * 1000 to make sessions expire in 24 hours.
  #   // Default is null, making it a browser cookie, so the session will
  #   // last only for as long as the browser is open.
  #   maxAge: null,
  #   // Path that the cookie is valid for.
  #   path: '/',
  #   // Should the session cookie be HTTP-only? (See https://www.owasp.org/index.php/HttpOnly)
  #   httpOnly: true,
  #   // Should the session cookie be secure? (only valid for HTTPS sites)
  #   secure: false
  # },

  adapter: 'connect-redis'
  # host: 'localhost',
  # port: 6379,
  # ttl: <redis session TTL in seconds>,
  # db: 0,
  # pass: <redis auth password>,
  # prefix: 'sess:',



  # adapter: 'mongo',
  # url: 'mongodb://user:password@localhost:27017/dbname', // user, password and port optional
  # collection: 'sessions',
  # stringify: true,
  # mongoOptions: {
  #   server: {
  #     ssl: true
  #   }
  # }

