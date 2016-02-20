TwitchChannel = require './models/twitchChannel'

tools = require './tools'

module.exports = class Models
	constructor: (@db) ->

	getChannel: (name, type) =>
		if !type?
			if name.indexOf(':') == -1
				 type = 'twitch'
			else
				tokens = name.split ':'
				type = tokens[0]
				name = tokens[1]

		switch type
			when 'twitch'
				return @getTwitchChannel name

	getDatabase: -> @db

	getTwitchChannel: (name) =>
		name = tools.ensureChannelName name
		return new TwitchChannel name, @db
