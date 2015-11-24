Meteor.publish 'space_users', (spaceId)->
	unless this.userId
		return this.ready()

	selector = {}
	if spaceId
		selector.space = spaceId

	console.log '[publish] space_users ' + spaceId

	return Steedos.SpaceUsers.find(selector, {fields: {name:1}})