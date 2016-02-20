module.exports = class BaseModel
	constructor: ->
		@model = 'model'
		@name = ''

	_fixKey: (key) ->
		if key != ''
			key = ':' + key
		key

	methods =
		del: ['key']
		exists: ['key']
		get: ['key']
		hdel: ['key', 'field']
		hget: ['key', 'field']
		hgetall: ['key']
		hincrby: ['key', 'field', 'value']
		hset: ['key', 'field', 'value']
		sadd: ['key', 'member']
		scard: ['key']
		set: ['key', 'value']
		setex: ['key', 'ttl', 'value']
		sismember: ['key', 'member']
		smembers: ['key']
		srem: ['key', 'member']
		zadd: ['key', 'score', 'member']
		zincrby: ['key', 'increment', 'member']
		zrank: ['key', 'member']
		zscore: ['key', 'member']

	for method, args of methods
		do (method, args) ->
			if args.length == 3
				BaseModel::['_' + method] = ->
					@db[method] @model + ':' + @name + @_fixKey(arguments[0]), arguments[1], arguments[2], arguments[3]
			if args.length == 2
				BaseModel::['_' + method] = ->
					@db[method] @model + ':' + @name + @_fixKey(arguments[0]), arguments[1], arguments[2]
			if args.length == 1
				BaseModel::['_' + method] = ->
					@db[method] @model + ':' + @name + @_fixKey(arguments[0]), arguments[1]
