Meteor.publish 'spaces', ->
	unless this.userId
		return this.ready()

	console.log '[publish] spaces'

	return Steedos.Spaces.find({}, {fields: {name:1}})