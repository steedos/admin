Template.sidebar.helpers
	apps: ->
		return Steedos.apps.find();

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
	

	avatar: ->
		if (Meteor.user())
			return Meteor.user().avatar