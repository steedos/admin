Template.launchpad.helpers
		
	userApps: ->
		return Steedos.Apps.find();

Template.launchpad.onCreated ->
	
	#Meteor.subscribe "apps"