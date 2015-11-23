Meteor.publish 'apps', ->

 	console.log '[publish] apps'

 	return Steedos.Apps.find()