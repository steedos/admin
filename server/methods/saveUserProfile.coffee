Meteor.methods
	saveUserProfile: (settings) ->
		if Meteor.userId()
			if settings.locale?
				if (settings.locale == "en")
					settings.locale = "en-us";
				if (settings.locale == "zh-CN")
					settings.locale = "zh-cn";
				Steedos.models.Users.setLocale Meteor.userId(), settings.locale

			if settings.username?
				Steedos.models.Users.setUsername Meteor.userId(), settings.username

			if settings.timezone?
				Steedos.models.Users.setTimezone Meteor.userId(), settings.timezone

			if settings.name?
				Steedos.models.Users.setName Meteor.userId(), settings.name

			if settings.email?
				Steedos.models.Users.setEmail Meteor.userId(), settings.email

			if settings.avatar?
				Steedos.models.Users.setAvatar Meteor.userId(), settings.avatar

			# if settings.profile
			# 	profile = settings.profile
			# 	Steedos.models.Users.setProfile Meteor.userId(), profile

			return true
