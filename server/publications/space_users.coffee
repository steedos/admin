Meteor.publish 'space_users', (spaceId)->
	unless this.userId
		return this.ready()

	selector = {}
	if spaceId
		selector.space = spaceId

	console.log '[publish] space_users ' + spaceId

	return db.space_users.find(selector)