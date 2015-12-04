Meteor.startup ->
	Meteor.subscribe "apps"

	spaceCallbacks =
		onReady: ->
			space = db.spaces.findOne()
			Meteor.call "setSpaceId", space._id, ->
				Session.set("spaceId", space._id)
		# onStop: (error)->
		# 	debugger
		# 	if !error
		# 		Meteor.subscribe "spaces", spaceCallbacks

	Meteor.subscribe "spaces", spaceCallbacks

	Tracker.autorun ->
		Meteor.subscribe "users", Session.get("spaceId")
		Meteor.subscribe "organizations", Session.get("spaceId")
		Meteor.subscribe "space_users", Session.get("spaceId")
