cli = require 'cli-color'
fs = require 'fs'
moment = require 'moment'

module.exports =
	consoleLog: (message) =>
		console.log message
		# fs.appendFileSync 'logs/mikuia/' + moment().format('YYYY-MM-DD') + '.txt', message + '\n'

	log: (category, message, status, color) ->
		if !message?
			message = category
			category = null
			
		output = moment().format('HH:mm:ss') + ' '

		if status?
			if color?
				output += '[' + color(status) + '] '
			else
				output += '[' + status + '] '

		if category
			output += category + ' / '

		if message?
			output += cli.whiteBright(message)

		@consoleLog output

	success: (category, message) ->
		@log category, message, 'Success', cli.greenBright

	info: (category, message) ->
		@log category, message, 'Info', cli.whiteBright

	warning: (category, message) ->
		@log category, message, 'Warning', cli.yellowBright

	error: (category, message) ->
		@log category, message, 'Error', cli.redBright

	fatal: (category, message) ->
		@log category, message, 'Fatal', cli.red
		process.exit 1
