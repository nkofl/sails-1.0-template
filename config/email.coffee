nodemailer = require 'nodemailer'
passwords = require './passwords.json'

module.exports.email = 
  transporter: nodemailer.createTransport(passwords.email)
  from: passwords.emailFrom
  testMode: false
  links: passwords.emailLinks
