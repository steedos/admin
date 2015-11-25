Meteor.publish 'organizations', (spaceId)->
	
	unless this.userId
		return this.ready()
	
	unless spaceId
		return this.ready()

	selector = {}
	selector.space = spaceId

	console.log '[publish] organizations ' + spaceId

	return db.organizations.find(selector)