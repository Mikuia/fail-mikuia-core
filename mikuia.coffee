cli = require 'cli-color'
redis = require 'redis'

log = require './src/log'

Chat = require './src/chat'
Messaging = require './src/messaging'
Settings = require './src/settings'

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

	db.on 'error', (err) =>
		log.fatal 'Redis', 'Error: ' + err

	msg = new Messaging config.zeromq.address
	chat = new Chat config.bot, db
