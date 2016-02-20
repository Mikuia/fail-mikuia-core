cli = require 'cli-color'
fs = require 'fs'

log = require './log'
tools = require './tools'

defaultSettings =
	twitch:
		enabled: true
		admins: [
			'hatsuney'
		]
		connections: 2
		debug: false
		disableChat: false
		name: 'YourBotNameHere'
		oauth: 'oauth:YOUR_TWITCH_IRC_OAUTH_KEY'
		autojoin: []
	redis:
		host: '127.0.0.1'
		port: 6379
		db: 0
		options:
			auth_pass: '',
	zeromq:
		address: 'tcp://127.0.0.1:3001'

module.exports = class Settings
	settings = {}

	read: (callback) =>
		fs.readFile 'settings.json', (err, data) =>
			if err
				log.error cli.whiteBright err
				log.warning cli.whiteBright 'Can\'t load the settings file, creating a new one.'
			else
				settings = tools.parseJson data

			@setDefaults()
			callback settings

	save: ->
		fs.writeFileSync 'settings.json', JSON.stringify settings, null, '\t'

	set: (category, key, value) ->
		settings[category][key] = value
		log.info cli.whiteBright('Setting ' + cli.greenBright(category + '.' + key) + ' to ' + cli.yellowBright(value))
		@save()

	setDefaults: ->
		for category, categoryFields of defaultSettings
			if not settings[category]?
				settings[category] = {}
			for field, fieldDefaultValue of categoryFields
				if not settings[category][field]?
					@set category, field, fieldDefaultValue
