Meteor.publish 'userData', ->
	unless this.userId
		return this.ready()

	console.log '[publish] userData'

	Steedos.Users.find this.userId,
		fields:
			name: 1
			email: 1
			company: 1
			mobile: 1
			locale: 1
			timezone: 1
			username: 1
			utcOffset: 1
			settings: 1
