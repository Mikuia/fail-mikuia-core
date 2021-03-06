async = require 'async'
cli = require 'cli-color'
tmi = require 'tmi.js'

Chat = require '../chat'
Models = require '../models'
RollingLimiter = require 'rolling-rate-limiter'

log = require '../log'
tools = require '../tools'

module.exports = class TwitchChat extends Chat
	constructor: (@config, @models) ->
		@clients = {}
		@clientJoins = []
		@whisperClient = null

	connect: ->
		connectionCount = @config.connections
		if typeof connectionCount isnt 'number' or connectionCount < 1
			connectionCount = 1

		async.map [0..(connectionCount - 1)], (id, callback) =>
			@spawnConnection id, 'main', callback
		, (err, results) =>
			for client, id in results
				@clients[id] = client
				@clientJoins[id] = []

			@join 'hatsuney'

		@spawnConnection null, 'group', (err, client) =>
			return if err
			@whisperClient = client

		@joinLimiter = RollingLimiter
			interval: 10000
			maxInInterval: 49
			namespace: 'mikuia:join:limiter'
			redis: @models.getDatabase()

		@messageLimiter = RollingLimiter
			interval: 30000
			maxInInterval: 19
			namespace: 'mikuia:chat:limiter:'
			redis: @models.getDatabase()

		@whisperLimiter = RollingLimiter
			interval: 60000
			maxInInterval: 99
			minDifference: 500
			namespace: 'mikuia:whisper:limiter'
			redis: @models.getDatabase()

	join: (channel, callback) =>
		channel = @models.getTwitchChannel channel

		channel.isPrioritized (err, prioritized) =>
			if prioritized
				@spawnConnection channel.getName(), 'main', (err, client) =>
					client.join channel.getName()
			else
				# todo: "load balancing"
				@clients[0].join channel.getName()

	spawnConnection: (id, type, callback) =>
		client = new tmi.client
			options:
				debug: @config.debug
			connection:
				cluster: type
				reconnect: false
			identity:
				username: @config.name
				password: @config.oauth

		if id? then client.id = id

		logHeader = ''
		if type == 'main' and client.id?
			logHeader = cli.cyanBright('[' + client.id + '] ')
		else if type == 'group'
			logHeader = cli.magentaBright('[Group] ')

		client.connect()

		client.on 'connected', (address, port) =>
			log.info 'Twitch', logHeader + cli.whiteBright(' Connected to ') + cli.yellowBright(address + ':' + port)

			client.raw 'CAP REQ :twitch.tv/membership'
			client.raw 'CAP REQ :twitch.tv/commands'
			client.raw 'CAP REQ :twitch.tv/tags'

			callback false, client

		client.on 'disconnected', (reason) =>
			log.error 'Twitch', logHeader + cli.whiteBright(' Disconnected. ' + reason)
			client.connect()

		client.on 'join', (channel, username) =>
			if username is @config.name.toLowerCase()
				 log.info 'Twitch', logHeader + cli.whiteBright('/ ') + cli.cyanBright(channel) + cli.whiteBright(' / Joined the channel.')

		client.on 'part', (channel, username) =>
			if username is @config.name.toLowerCase()
				log.info 'Twitch', logHeader + cli.whiteBright('/ ') + cli.cyanBright(channel) + cli.whiteBright(' / Left the channel.')

		# if type == 'main'
		# 	# client.on('message')
		#
		# if type == 'group'
		# 	# client.on('whisper')
