Meteor.startup ->

	Meteor.subscribe("userData")

	@defaultUserLanguage = ->
		lng = window.navigator.userLanguage || window.navigator.language || 'en'
		# Fix browsers having all-lowercase language settings eg. pt-br, en-us
		re = /([a-z]{2}-)([a-z]{2})/
		if re.test lng
			lng = lng.replace re, (match, parts...) -> return parts[0] + parts[1].toUpperCase()
		return lng
		
	loadedLaguages = []

	setLanguage = (language) ->
		if language == "en-us"
			language = "en"
		if language == "zh-cn"
			language = "zh-CN"

		Session.set("language", language)

		if loadedLaguages.indexOf(language) > -1
			return

		loadedLaguages.push language

		TAPi18n.setLanguage(language)

		language = language.toLowerCase()
		if language isnt 'en'
			Meteor.call 'loadLocale', language, (err, localeFn) ->
				Function(localeFn)()
				moment.locale(language)

	Tracker.autorun (c) ->
		if Meteor.user()?locale
			c.stop()
			setLanguage Meteor.user().locale

	userLanguage = Meteor.user()?.locale

	if !userLanguage
		userLanguage = defaultUserLanguage()

	setLanguage userLanguage
