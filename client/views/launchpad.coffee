Template.launchpad.helpers
		
	userApps: ->
		return db.apps.find();

Template.launchpad.onCreated ->
	
	#Meteor.subscribe "apps"