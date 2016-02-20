cli = require 'cli-color'
redis = require 'redis'

log = require './src/log'

Messaging = require './src/messaging'
Models = require './src/models'
Settings = require './src/settings'

TwitchChat = require './src/services/twitchChat'

# This code is trash.

chat = null
config = null
db = null

settings = new Settings()

settings.read (data) =>
	config = data

	db = redis.createClient config.redis.port, config.redis.host, config.redis.options
	db.on 'ready', =>
		log.info 'Redis', 'Connected.'
		db.select config.redis.db

	db.on 'error', (err) =>
		log.fatal 'Redis', 'Error: ' + err

	models = new Models db
	msg = new Messaging config.zeromq.address

	if config.twitch.enabled
		twitchChat = new TwitchChat config.twitch, models
		twitchChat.connect()
