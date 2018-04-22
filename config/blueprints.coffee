module.exports.blueprints = 
  actions: false
  rest: true
  shortcuts: false
  # prefix: ''
  restPrefix: '/api'
  pluralize: false
  # autoWatch: true
  parseBlueprintOptions: (req) ->
    queryOptions = req._sails.hooks.blueprints.parseBlueprintOptions(req)
    if req.options.blueprintAction == 'find' || req.options.blueprintAction == 'populate'
      if queryOptions.criteria.limit > 1000
        queryOptions.criteria.limit = 1000
    queryOptions
