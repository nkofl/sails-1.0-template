module.exports = (req, res, proceed) ->
  await Promise.resolve()
  if !req.session?.user
    req.session.returnTo = req.url
    if req.isSocket || req.wantsJSON
      res.unauthorized()
    else
      res.redirect('/auth/required')
  else 
    proceed()
# if using permissions:
#  if !req.session.permissions
#    req.session.returnTo = req.path
#    return res.unauthorized()
#  else if req.isSocket
#    if req.session && req.session.user
#      req.user = req.session.user
#      return proceed()
#    else 
#      return res.unauthorized()
#  else if req.user
#    return proceed()
#  else
#    return res.unauthorized()
#
