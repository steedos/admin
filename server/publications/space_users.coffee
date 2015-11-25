Meteor.publish 'space_users', (spaceId)->
	unless this.userId
		return this.ready()

	unless spaceId
		return this.ready()

	selector = {}
	selector.space = spaceId

	console.log '[publish] space_users ' + spaceId

	return db.space_users.find(selector)