Meteor.methods
	saveUserProfile: (settings) ->
		if Meteor.userId()
			if settings.language?
				Steedos.models.Users.setLanguage Meteor.userId(), settings.language

			# if settings.username?
			# 	Meteor.call 'setUsername', settings.username

			if settings.name?
				Steedos.models.Users.setName Meteor.userId(), settings.name

			profile = {}

			Steedos.models.Users.setProfile Meteor.userId(), profile

			return true
