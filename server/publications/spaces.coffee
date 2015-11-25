Meteor.publish 'spaces', ->
	unless this.userId
		return this.ready()

	user = db.users.findOne(this.userId);
	user_space_ids = []
	user_spaces = db.space_users.find({user: this.userId});
	user_spaces.forEach (space_user) ->
		user_space_ids.push(space_user.space)

	selector = {}
	selector._id = {$in: user_space_ids}

	console.log '[publish] spaces ' + JSON.stringify(user_space_ids)

	return db.spaces.find(selector)