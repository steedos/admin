Template.AdminHeader.helpers

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

	spacesCount: ->
		return Steedos.spaces.find().count()

	spaces: ->
		return Steedos.spaces.find().fetch()

	spaceName: ->
		if (Session.get("spaceName"))
			return Session.get("spaceName")
		return t("Select Space")


Template.AdminHeader.events

	"click #switchSpace": ->
		Session.set("spaceId", this._id)
		Session.set("spaceName", this.name)
		Router.go "/admin"



Meteor.startup ->
	Template.SteedosAdminHeader.replaces("AdminHeader");


