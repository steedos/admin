Meteor.publish 'users', ->
	unless this.userId
		return this.ready()

	console.log '[publish] users'

	return Steedos.Users.find({}, {fields: {name: 1}})