Meteor.publish 'organizations', ->
	unless this.userId
		return this.ready()

	console.log '[publish] organizations'

	return Steedos.Organizations.find({}, {fields: {name:1}})