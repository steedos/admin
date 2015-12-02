Meteor.startup ->
	Meteor.subscribe "apps"
	Meteor.subscribe "spaces", ->
		space = db.spaces.findOne()
		Meteor.call "setSpaceId", space._id, ->
			Session.set("spaceId", space._id)

	Tracker.autorun ->
		Meteor.subscribe "users", Session.get("spaceId")
		Meteor.subscribe "organizations", Session.get("spaceId")
		Meteor.subscribe "space_users", Session.get("spaceId")
