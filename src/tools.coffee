log = require './log'

module.exports =
	parseJson: (json) =>
		try
			JSON.parse json
		catch e
			log.error 'Oh come on, that\'s not even a proper JSON message!'
			null
