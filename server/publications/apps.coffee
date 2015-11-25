Meteor.publish 'apps', ->

 	console.log '[publish] apps'

 	return db.apps.find()