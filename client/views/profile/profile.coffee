Template.profile.helpers
	user: ->
		return Meteor.user()

	languages: ->
		languages = TAPi18n.getLanguages()
		result = []
		for key, language of languages
			result.push _.extend(language, { key: key })
		return _.sortBy(result, 'key')

	timezone: ->
		if Meteor.user()?.timezone?
			return Meteor.user().timezone
		else
			return TimezonePicker.detectedZone()

	userLanguage: (key) ->
		if Session.get("language")
			return Session.get("language") is key
		else
			return defaultUserLanguage() is key

	setChecked: (value, currentValue) ->
	    if(value == currentValue) 
	       return "checked"
	    else 
	       return ""

	getGravatarURL: (user, size) ->
		if (Meteor.user())
			return Meteor.user().avatar

Template.profile.onRendered ->

    $('select.dropdown').dropdown()

Template.profile.onCreated ->


	@saveProfile = ->
		instance = @
		reload = false
		data = { profile: {} }

		selectedLanguage = $('#language').val()

		data.locale = selectedLanguage
		if Session.get("language") isnt selectedLanguage
			Session.set("language", selectedLanguage)
			reload = true

		# if _.trim $('#username').val()
		# 	data.username = _.trim $('#username').val()

		if _.trim $('#name').val()
			data.name = _.trim $('#name').val()

		if _.trim $('#company').val()
			data.company = _.trim $('#company').val()

		if _.trim $('#mobile').val()
			data.mobile = _.trim $('#mobile').val()

		if _.trim $('#email').val()
			data.email = _.trim $('#email').val()

		if $('select[name=pickedTimezone]').val()
			data.timezone = $('select[name=pickedTimezone]').val()

		Meteor.call 'saveUserProfile', data, (error, results) ->
			if results
				toastr.success t('Profile_saved_successfully')
				if reload
					setTimeout ->
						Meteor._reload.reload()
					, 1000

			if error
				toastr.error error.reason



		
Template.profile.events
	'click #saveProfile': (e, t) ->
		t.saveProfile()