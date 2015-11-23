Meteor.startup ->
	Migrations.add
		version: 2
		up: -> 
			Steedos.Users.find().forEach (user) ->
				if (user._id instanceof Mongo.ObjectID)
					user._oid = user._id
					user._id = user._oid._str
					Steedos.Users.remove {_id: user._oid}
					Steedos.Users.insert user