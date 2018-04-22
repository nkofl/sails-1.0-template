'use strict';
async = require 'async'

dbm = undefined
type = undefined
seed = undefined

exports.setup = (options, seedLink) ->
  dbm = options.dbmigrate
  type = dbm.dataType
  seed = seedLink

exports.up = (db) ->
  await db.createTable 'user',
    columns:
      id: {type: 'uuid', notNull: true, primaryKey: true }
      created_at: {type: 'timestamp', timezone: true}
      updated_at: {type: 'timestamp', timezone: true}
      email: {type: 'string', defaultValue: '', notNull: true}
      first_name: {type: 'string', defaultValue: ''}
      last_name: {type: 'string', defaultValue: ''}
      company: {type: 'string', defaultValue: ''}
      mobile_phone: {type: 'string', defaultValue: ''}
      direct_phone: {type: 'string', defaultValue: ''}
      address: {type: 'string', defaultValue: ''}
      city: {type: 'string', defaultValue: ''}
      state: {type: 'string', defaultValue: ''}
      zip: {type: 'string', defaultValue: ''}
      password: {type: 'string', defaultValue: '', notNull: true}
      is_admin: {type: 'boolean', defaultValue: false, notNull: true}
      reset_token: {type: 'string'}
      reset_expires: {type: 'timestamp', timezone: true}
      email_token: {type: 'string'}
      email_expires: {type: 'timestamp', timezone: true}
      email_status: {type: 'string'}
      email_change_candidate: {type: 'string'}
  await db.createTable 'log',
    columns:
      id: {type: 'uuid', notNull: true, primaryKey: true }
      created_at: {type: 'timestamp', timezone: true}
      updated_at: {type: 'timestamp', timezone: true}
      resource_id: {type: 'uuid'}
      resource_type: {type: 'string'}
      category: {type: 'string', defaultValue: '', notNull: true}
      message: {type: 'string', defaultValue: '', notNull: true}
  await db.createTable 'session',
    columns:
      id: {type: 'uuid', notNull: true, primaryKey: true }
      created_at: {type: 'timestamp', timezone: true}
      updated_at: {type: 'timestamp', timezone: true}
      user_id: {type: 'uuid', notNull: true}
      ip: {type: 'string', notNull: true}
  await db.addIndex 'user', 'user_IX_email', ['email']
  await db.addIndex 'log', 'log_IX_resource_id_created_at', ['resource_id', 'created_at']
  await db.addIndex 'session', 'session_IX_user_id_created_at', ['user_id', 'created_at']
  await db.addForeignKey 'session', 'user', 'FK_public.session_public.user_user_id', {'user_id': 'id'}, {onDelete: 'CASCADE', onUpdate: 'RESTRICT'}

exports.down = (db) ->
  await db.removeForeignKey 'session', 'FK_public.session_public.user_user_id'
  await db.removeIndex 'log', 'session_IX_user_id_created_at'
  await db.removeIndex 'log', 'log_IX_resource_id_created_at'
  await db.removeIndex 'log', 'user_IX_email'
  await db.dropTable 'session'
  await db.dropTable 'log'
  await db.dropTable 'user'
