Meteor.startup ->
	if db.users.find().count() == 0
		users = [
			{name:"Administrator",email:"support@steedos.com",roles:['admin']}
		];

		_.each users, (user) ->

			id = Accounts.createUser
				email: user.email,
				password: "123456",
				name: user.name
			

			if (user.roles.length > 0) 
				Roles.addUsersToRoles(id, user.roles, 'default-group');
