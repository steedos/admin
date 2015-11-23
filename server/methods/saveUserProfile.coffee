Meteor.methods
	saveUserProfile: (settings) ->
		if Meteor.userId()
			updateValues = {}

			if settings.locale?
				if (settings.locale == "en")
					settings.locale = "en-us";
				if (settings.locale == "zh-CN")
					settings.locale = "zh-cn";
				updateValues.locale = settings.locale

			if settings.username?
				updateValues.username = settings.username

			if settings.timezone?
				updateValues.timezone = settings.timezone

			if settings.name?
				updateValues.name = settings.name

			if settings.company?
				updateValues.company = settings.company

			if settings.mobile?
				updateValues.mobile = settings.mobile

			if settings.email?
				updateValues.email = settings.email

			if settings.avatar?
				updateValues.avatar = settings.avatar

			Steedos.Users.update(Meteor.userId(), {
				$set: updateValues
			})

			return true
