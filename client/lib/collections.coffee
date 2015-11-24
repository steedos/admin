Meteor.startup ->
	Meteor.subscribe "apps"
	Meteor.subscribe "users"
	Meteor.subscribe "spaces"

	Tracker.autorun ->
		Meteor.subscribe "organizations", Session.get("spaceId")

		Meteor.subscribe "space_users", Session.get("spaceId")
