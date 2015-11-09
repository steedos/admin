Template.dockLeft.helpers
		
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


Template.dockLeft.onRendered ->
	
	$('html').addClass "dockOnLeft"

	$('.ui.menu .ui.dropdown').dropdown({on: 'hover'});


Template.dockLeft.events

	"click .ui.menu a.item": ->
		$(this).addClass('active').siblings().removeClass('active')
