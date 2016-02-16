Channel = require './models/channel'

tools = require './tools'

module.exports = class Models
	constructor: (@db) ->

	getChannel: (name) =>
		name = tools.ensureChannelName name
		return new Channel(name, @db)

	getDatabase: -> @db
