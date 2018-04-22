module.exports =
  attributes: 
    user: { columnName: 'user_id', model: 'user', via: 'id', required: true, unique: true }
    ip: {type: 'string', required: true }


