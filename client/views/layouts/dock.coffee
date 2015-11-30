Template.dock.helpers
		
	user: ->
		return Meteor.user();

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
		if (Meteor.user().avatar)
			return Meteor.user().avatar
		else
			return "/avatar/" + Meteor.user().emails[0].address

	spaces: ->
		return db.spaces.find();

	spaceName: ->
		if (Session.get("spaceName"))
			return Session.get("spaceName")
		return t("Steedos Cloud")


Template.dock.onRendered ->
	
	$('html').addClass "dockOnTop"

	$('.ui.dropdown').dropdown({on: 'hover'});


Template.dock.events

	"click .ui.menu a.item": ->
		$(this).addClass('active').siblings().removeClass('active')

	"click #switchSpace": ->
		Session.set("spaceId", this._id)
		Session.set("spaceName", this.name)
