Meteor.startup ->
	if Meteor.roles.find().count() == 0
		admins = ['support@steedos.com'];

		_.each admins, (admin) ->
			id = db.users.findOne({"emails.address": admin})
			if id
				console.log '[initialize] set user as admin:' + admin
				Roles.addUsersToRoles(id, 'admin', Roles.GLOBAL_GROUP);
