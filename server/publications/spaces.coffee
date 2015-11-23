Meteor.publish 'spaces', ->

 	console.log '[publish] spaces'

 	return Steedos.Spaces.find()