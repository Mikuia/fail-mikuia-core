log = require './log'

module.exports =
	parseJson: (json) =>
		jsonData = null

		try
			jsonData = JSON.parse json
		catch e
			log.error 'Oh come on, that\'s not even a proper JSON message!'

		return jsonData
