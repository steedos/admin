Meteor.publish 'users', ->

 	console.log '[publish] users'

 	return Steedos.collections.Users.find({}, {fields: {name: 1}})