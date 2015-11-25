Meteor.startup ->
	Migrations.add
		version: 2
		up: -> 
			db.users.find().forEach (user) ->
				if (user._id instanceof Mongo.ObjectID)
					user._oid = user._id
					user._id = user._oid._str
					db.users.remove {_id: user._oid}
					db.users.insert user