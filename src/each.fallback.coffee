###
Enumerate system root CAs synchronously
###
path = require 'path'
spawn = require 'child_process'
  .spawnSync

split = require 'split'
forge = require 'node-forge'

asn1 = forge.asn1
pki = forge.pki

bufferFrom = Buffer.from or (data, encoding)->
  new Buffer data, encoding

module.exports = (cb)->
  child = spawn path.join __dirname, 'roots'
  split (blob)->
    unless blob
      return
    blob = bufferFrom blob, 'hex'
    cb pki.certificateFromAsn1 asn1.fromDer blob.toString 'binary'
  .end child.stdout
  return
