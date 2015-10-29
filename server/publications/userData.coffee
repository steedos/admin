Meteor.publish 'userData', ->
	unless this.userId
		return this.ready()

	console.log '[publish] userData'.green

	Steedos.models.Users.find this.userId,
		fields:
			name: 1
			email: 1
			username: 1
			utcOffset: 1
			language: 1
			settings: 1
