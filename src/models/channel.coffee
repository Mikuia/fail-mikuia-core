BaseModel = require('./base')

module.exports = class Channel extends BaseModel
	constructor: (@name, @db) ->
		@model = 'channel'
		@type = ''
		# Woop

	getFullName: -> @type + ':' + @name
	getName: -> @name

	isBanned: (cb) -> @db.sismember 'mikuia:banned', @getFullName(), cb
	isBot: (cb) -> @db.sismember 'mikuia:bots', @getFullName(), cb
	isLevelDisabled: (cb) -> @db.sismember 'mikuia:levels:disabled', @getFullName(), cb
	isLive: (cb) -> @db.sismember 'mikuia:streams', @getFullName(), cb
	isPrioritized: (cb) -> @db.sismember 'mikuia:prioritized', @getFullName(), cb
	isStreamer: (cb) -> @_exists 'plugins', cb
