Meteor.publish 'apps', ->

 	console.log '[publish] apps'

 	return Apps.find()