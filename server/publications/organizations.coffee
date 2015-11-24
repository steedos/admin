Meteor.publish 'organizations', (spaceId)->
	unless this.userId
		return this.ready()

	selector = {}
	if spaceId
		selector.space = spaceId

	console.log '[publish] organizations ' + spaceId

	return Steedos.Organizations.find(selector, {fields: {name:1}})