Template.sidebar.helpers

	displayName: ->

		if Meteor.user()
			return Meteor.user().displayName()
		else
			return " "
	
	avatar: ->
		if Meteor.user()
			if Meteor.user().avatar
				return Meteor.user().avatar
			else
				return "/avatar/" + Meteor.user().emails[0].address