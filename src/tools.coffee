log = require './log'

module.exports =

	ensureChannelName: (channel) =>
		if channel.indexOf('#') > -1
			channel = channel.split('#').join('')

		channel = channel.toLowerCase()
		return channel

	parseJson: (json) =>
		jsonData = null

		try
			jsonData = JSON.parse json
		catch e
			log.error 'Oh come on, that\'s not even a proper JSON message!'

		return jsonData
