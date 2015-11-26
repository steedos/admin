Meteor.startup ->
	if Meteor.roles.find().count() == 0
		admins = ['support@steedos.com'];

		_.each admins, (admin) ->
			id = db.users.findOne({"email.address": admin})
			if id
				Roles.addUsersToRoles(id, 'admin');
