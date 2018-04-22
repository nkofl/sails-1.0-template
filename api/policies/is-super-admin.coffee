module.exports = (req, res, proceed) ->
  if !req.session?.user
    req.session.returnTo = req.url
    res.unauthorized()
  if !req.session.user.isSuperAdmin
    res.forbidden()
  else 
    proceed()
