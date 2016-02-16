module.exports = class BaseModel
	constructor: ->
		@model = 'model'
		@name = ''

	_fixKey: (key) ->
		if key != ''
			key = ':' + key
		key

	_getModel: -> @model

	# methods =
	# 	del: ['key']
	# 	exists: ['key']
	# 	get: ['key']
	# 	hdel: ['key', 'field']
	#
	# for method, args of methods
	# 	console.log method
	# 	console.log args
	#
	# 	if args.length == 3
	# 		BaseModel::['_' + method] = -> @db[method] @_getModel() + ':' + @name + @_fixKey(arguments[0]), arguments[1], arguments[2], arguments[3]
	# 	if args.length == 2
	# 		BaseModel::['_' + method] = -> @db[method] @_getModel() + ':' + @name + @_fixKey(arguments[0]), arguments[1], arguments[2]
	# 	if args.length == 1
	# 		console.log '@db[' + method + '] ' + @_getModel() + ':' + @name
	# 		#  + @_fixKey(arguments[0]) + ', ' + arguments[1]
	# 		BaseModel::['_' + method] = -> @db[method] @_getModel() + ':' + @name + @_fixKey(arguments[0]), arguments[1]

	#
	# _del: (key, cb) -> @db.del @model + ':' + @name + @_fixKey(key), cb
	_exists: (key, cb) -> @db.exists @model + ':' + @name + @_fixKey(key), cb
	# _get: (key, cb) -> @db.get @model + ':' + @name + @_fixKey(key), cb
	# _hdel: (key, field, cb) -> @db.hdel @model + ':' + @name + @_fixKey(key), field, cb
	# _hget: (key, field, cb) -> @db.hget @model + ':' + @name + @_fixKey(key), field, cb
	# _hgetall: (key, cb) -> @db.hgetall @model + ':' + @name + @_fixKey(key), cb
	# _hincrby: (key, field, value, cb) -> @db.hincrby @model + ':' + @name + @_fixKey(key), field, value, cb
	# _hset: (key, field, value, cb) -> @db.hset @model + ':' + @name + @_fixKey(key), field, value, cb
	# _sadd: (key, member, cb) -> @db.sadd @model + ':' + @name + @_fixKey(key), member, cb
	# _scard: (key, cb) -> @db.scard @model + ':' + @name + @_fixKey(key), cb
	# _set: (key, value, cb) -> @db.set @model + ':' + @name + @_fixKey(key), value, cb
	# _setex: (key, ttl, value, cb) -> @db.setex @model + ':' + @name + @_fixKey(key), ttl, value, cb
	# _sismember: (key, member, cb) -> @db.sismember @model + ':' + @name + @_fixKey(key), member, cb
	# _smembers: (key, cb) -> @db.smembers @model + ':' + @name + @_fixKey(key), cb
	# _srem: (key, member, cb) -> @db.srem @model + ':' + @name + @_fixKey(key), member, cb
	#
