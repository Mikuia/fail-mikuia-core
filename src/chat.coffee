cli = require 'cli-color'
tmi = require 'tmi.js'

log = require './log'

module.exports = class Chat
	@clients = {}
	@clientJoins = []

	constructor: (@config, @db) ->
		connectionCount = @config.connections
		if typeof connectionCount isnt 'number' or connectionCount < 1
			connectionCount = 1

		for id in [0..(connectionCount - 1)]
			@spawnConnection id, (err, client) =>
				if !err
					@clients[id] = client
					@clientJoins[id] = []

	spawnConnection: (id, callback) =>
		client = new tmi.client
			options:
				debug: @config.debug
			connection:
				cluster: 'main'
				reconnect: true
			identity:
				username: @config.name
				password: @config.oauth

		client.id = id
		client.connect()

		client.on 'connected', (address, port) =>
			log.info 'Twitch', cli.cyanBright('[' + client.id + ']') + cli.whiteBright(' Connected to ') + cli.yellowBright(address + ':' + port)
