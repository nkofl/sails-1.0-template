module.exports = (cb) ->
  sails.on 'lifted', () ->
    if process.send
      process.send 'ready'
  process.on 'SIGINT', (message) ->
    sails.log message
    sails.log "Shutdown signal received...shutting down"
    sails.lower (err) ->
      if err
        console.log "An error occured while stopping app: ", err
      console.log "Shutdown complete. Process terminating."
      process.exit 0
  sails.on 'lower', () ->
    # Give Sails five seconds to shut down before pulling the plug.
    setTimeout(() ->
      process.exit(1)
    , 10000)
  cb()
