Meteor.startup ->
	Meteor.subscribe "apps"
	Meteor.subscribe "spaces"

	Tracker.autorun ->
		Meteor.subscribe "users", Session.get("spaceId")
		Meteor.subscribe "organizations", Session.get("spaceId")
		Meteor.subscribe "space_users", Session.get("spaceId")
