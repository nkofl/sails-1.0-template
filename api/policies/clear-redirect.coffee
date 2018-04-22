module.exports = (req, res, proceed) ->
  req.session.returnTo = null
  proceed()