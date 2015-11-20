Template.launchpad.helpers
		
	userApps: ->
		return Steedos.collections.Apps.find();

Template.launchpad.onCreated ->
	
	#Meteor.subscribe "apps"