Meteor.startup ->
	Meteor.subscribe "apps"
	Meteor.subscribe "spaces", ->
		space = db.spaces.findOne()
		Session.set "spaceId", space._id

	Tracker.autorun ->
		Meteor.call "setSpaceId", Session.get("spaceId")
		Meteor.subscribe "users", Session.get("spaceId")
		Meteor.subscribe "organizations", Session.get("spaceId")
		Meteor.subscribe "space_users", Session.get("spaceId")
