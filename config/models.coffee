uuid = require 'uuid'
passwords = require './passwords.json'

module.exports.models = 
  migrate: 'safe'
  datastore: 'main'
  attributes: 
    id: 
      type: 'string'
      columnType: 'uuid'
      required: true
    createdAt: 
      type: 'ref'
      columnType: 'timestamp'
      columnName: 'created_at'
      autoCreatedAt: true
    updatedAt: 
      type: 'ref'
      columnType: 'timestamp'
      columnName: 'updated_at'
      autoCreatedAt: true

  dataEncryptionKeys: 
    default: passwords.dek

  cascadeOnDestroy: true
