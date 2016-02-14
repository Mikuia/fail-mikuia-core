cli = require 'cli-color'
zmq = require 'zmq'
_ = require 'underscore'

log = require './log'
tools = require './tools'

module.exports = class Messaging
	constructor: (address) ->
		@rep = zmq.socket 'rep'

		@rep.bindSync address
		@rep.on 'message', (msg) =>
			log.info cli.whiteBright('Received a message: ') + cli.greenBright(msg)
			@parseMessage tools.parseJson msg.toString()

		log.info cli.whiteBright('Listening on ') + cli.yellowBright(address)

	parseMessage: (req) =>
		return unless req?.method?
		switch req.method
			when "getExample"
				@reply req,
					type: 'string'
					message: 'Hatsu123'
					error: false
			else
				console.log 'What the shit are you doing.'
				@reply req,
					error: true

	reply: (req, res) =>
		@rep.send JSON.stringify _.extend(req, res)
