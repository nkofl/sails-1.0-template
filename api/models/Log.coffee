module.exports =
  attributes: 
    resourceId : { type: 'ref', columnName: 'resource_id', columnType: 'uuid' }
    resourceType: { type: 'string', columnName: 'resource_type' }
    category: {type: 'string', required: true }
    message: {type: 'string', required: true }


