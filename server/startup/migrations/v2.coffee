Meteor.startup ->
	Migrations.add
		version: 2
		up: -> 
			Steedos.models.Users.find().forEach (user) ->
				if (user._id instanceof Mongo.ObjectID)
					user._oid = user._id
					user._id = user._oid._str
					Steedos.models.Users.remove {_id: user._oid}
					Steedos.models.Users.insert user