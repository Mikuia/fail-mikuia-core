BaseModel = require('./base')

module.exports = class Channel extends BaseModel
	constructor: (@name, @db) ->
		@model = 'channel'
		# Woop

	getName: -> @name

	isBanned: (cb) -> @db.sismember 'mikuia:banned', @name, cb
	isBot: (cb) -> @db.sismember 'mikuia:bots', @name, cb
	isLevelDisabled: (cb) -> @db.sismember 'mikuia:levels:disabled', @name, cb
	isLive: (cb) -> @db.sismember 'mikuia:streams', @name, cb
	isPrioritized: (cb) -> @db.sismember 'mikuia:prioritized', @name, cb
	isStreamer: (cb) -> @_exists 'plugins', cb