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
		if Session.get("spaceId")
			space = db.spaces.findOne(Session.get("spaceId"))
			return space.name
		return t("Select Space")


Template.AdminHeader.events

	"click #switchSpace": ->
		self = this
		Meteor.call "setSpaceId", self._id, ->
			Session.set("spaceId", self._id)

		Router.go "/admin"



Meteor.startup ->
	Template.SteedosAdminHeader.replaces("AdminHeader");


