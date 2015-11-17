Template.dock.helpers
		
	user: ->
		return Meteor.user();

	userApps: ->
		return Apps.find();

	displayName: ->

		if Meteor.user()
			if Meteor.user().name
				return Meteor.user().name
			else if Meteor.user().email
				return Meteor.user().email
			else
				return Meteor.user()._id
		else
			return "Nobody"
	

	avatar: ->
		if (Meteor.user())
			return Meteor.user().avatar


Template.dock.onRendered ->
	
	$('html').addClass "dockOnTop"

	$('.ui.menu .ui.dropdown').dropdown({on: 'hover'});


Template.dock.events

	"click .ui.menu a.item": ->
		$(this).addClass('active').siblings().removeClass('active')
