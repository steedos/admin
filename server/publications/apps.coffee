Meteor.publish 'apps', ->

 	console.log '[publish] apps'

 	return Steedos.collections.Apps.find()