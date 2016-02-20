Channel = require './channel'

module.exports = class TwitchChannel extends Channel
	constructor: (@name, @db) ->
		@model = 'channel:twitch'
