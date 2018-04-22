module.exports = 
  attributes:
    email : { type: 'string',  unique: true, required: true, isEmail: true, maxLength: 200 }
    firstName: { type: 'string', columnName: 'first_name', defaultsTo: '', maxLength: 64 }
    lastName: { type: 'string', columnName: 'last_name', defaultsTo: '', maxLength: 64 }
    company: { type: 'string', defaultsTo: '', maxLength: 128 }
    mobilePhone: { type: 'string', columnName: 'mobile_phone', defaultsTo: '', maxLength: 32  }
    directPhone: { type: 'string', columnName: 'direct_phone', defaultsTo: '', maxLength: 32  }
    address: { type: 'string', defaultsTo: '', maxLength: 200  }
    city: { type: 'string', defaultsTo: '', maxLength: 64  }
    state: { type: 'string', defaultsTo: '', maxLength: 64  }
    zip: { type: 'string', defaultsTo: '', maxLength: 32  }
    password: { type: 'string', minLength: 6, maxLength: 64, protect: true, required: true }
    isAdmin: { type: 'boolean', defaultsTo: false, columnName: 'is_admin' }
    resetToken: { type: 'string', columnName: 'reset_token' }
    resetExpires: { type: 'ref', columnName: 'reset_expires', columnType: 'timestamp' }
    emailToken: { type: 'string', columnName: 'email_token' }
    emailExpires: { type: 'ref', columnName: 'email_expires', columnType: 'timestamp' }
    emailStatus: { type: 'string', isIn: ['unconfirmed', 'changeRequested', 'confirmed'], columnName: 'email_status', defaultsTo: 'unconfirmed' }
    emailChangeCandidate: { type: 'string', maxLength: 200, columnName: 'email_change_candidate' }
  customToJSON: () ->
    _.omit(this, ['password', 'resetToken', 'emailToken'])
  beforeUpdate: (values, next) ->
    if values.password
      values.password = await sails.helpers.encryptPassword values.password
    next()
  beforeCreate: (values, next) ->
    if values.password
      values.password = await sails.helpers.encryptPassword values.password
    next()
