Meteor.publish 'spaces', ->
	unless this.userId
		return this.ready()

	user = Steedos.Users.findOne(this.userId);
	user_space_ids = []
	user_spaces = Steedos.SpaceUsers.find({user: this.userId});
	user_spaces.forEach (space_user) ->
		user_space_ids.push(space_user.space)

	selector = {}
	selector._id = {$in: user_space_ids}

	console.log '[publish] spaces ' + JSON.stringify(user_space_ids)

	return Steedos.Spaces.find(selector)