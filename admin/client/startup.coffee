Meteor.startup ->
	
	Tracker.autorun (c) ->
		if Meteor.user()
			if Roles.userIsInRole Meteor.userId(), "admin"
				AdminController.prototype.layoutTemplate = "SpaceAdminLayout"
			else if Roles.userIsInRole Meteor.userId(), "admin", Session.get("spaceId")
				AdminController.prototype.layoutTemplate = "SpaceAdminLayout"
			c.stop()