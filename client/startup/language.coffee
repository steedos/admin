Meteor.startup ->

	Meteor.subscribe("userData")

	@defaultUserLanguage = ->
		lng = window.navigator.userLanguage || window.navigator.language || 'en'
		if lng.indexOf("zh") >=0
			return "zh-CN"
		else
			return "en"
		
	loadedLaguages = []

	# Only support [en, zh-CN]
	setLanguage = (language) ->

		if language == "zh-cn"
			language = "zh-CN"
		if language == "en-us"
			language = "en"

		Session.set("language", language)

		if loadedLaguages.indexOf(language) > -1
			return

		loadedLaguages.push language

		TAPi18n.setLanguage(language)

		if language == "zh-CN"
			T9n.setLanguage "zh_cn"
		else
			T9n.setLanguage "en"

		language = language.toLowerCase()
		if language isnt 'en'
			Meteor.call 'loadLocale', language, (err, localeFn) ->
				Function(localeFn)()
				moment.locale(language)

	Tracker.autorun (c) ->
		if Meteor.user()
			if Meteor.user().locale
				setLanguage Meteor.user().locale
				c.stop()

	userLanguage = defaultUserLanguage()

	setLanguage userLanguage
