Meteor.publish 'users', ->
	unless this.userId
		return this.ready()

	console.log '[publish] users'

	return db.users.find({}, {fields: {name: 1}})