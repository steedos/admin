Template.AdminHeader.helpers

	spaces: ->
		return db.spaces.find().fetch()

Template.AdminHeader.events

	"click #switchSpace": ->
		Session.set("spaceId", this._id)


Meteor.startup ->
	Template.SteedosAdminHeader.replaces("AdminHeader");


