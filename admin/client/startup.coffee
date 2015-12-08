Meteor.startup ->
	
	Tracker.autorun (c) ->
		if Meteor.user()
			if Roles.userIsInRole Meteor.userId(), "admin"
				AdminController.prototype.layoutTemplate = "SpaceAdminLayout"
				# Only Cloud Admin Can Access Users Object
				AdminConfig.collections.Users =
					collectionObject: Meteor.users
					icon: 'user'
					label: 'Users'
			else if Roles.userIsInRole Meteor.userId(), "admin", Session.get("spaceId")
				AdminController.prototype.layoutTemplate = "SpaceAdminLayout"
				if AdminConfig.collections.Users
					AdminConfig.collections.Users.showWidget = false
			