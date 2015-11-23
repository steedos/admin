Meteor.publish 'users', ->

 	console.log '[publish] users'

 	return Steedos.Users.find({}, {fields: {name: 1}})