Template.profile.helpers
	user: ->
		return Meteor.user()

	languages: ->
		languages = TAPi18n.getLanguages()
		result = []
		for key, language of languages
			result.push _.extend(language, { key: key })
		return _.sortBy(result, 'key')

	userLanguage: (key) ->
		return (localStorage.getItem('userLanguage') or defaultUserLanguage())?.split('-').shift().toLowerCase() is key

	setChecked: (value, currentValue) ->
	    if(value == currentValue) 
	       return "checked"
	    else 
	       return ""

	getGravatarURL: (user, size) ->
		if (Meteor.user())
			return Meteor.user().profile.avatar

Template.profile.onCreated ->

	@clearForm = ->
		@find('#oldPassword').value = ''
		@find('#password').value = ''
		@find('#confirmPassword').value = ''

	@changePassword = (callback) ->
		instance = @

		oldPassword = $('#oldPassword').val()
		password = $('#password').val()
		confirmPassword = $('#confirmPassword').val()

		if !oldPassword or !password or !confirmPassword
			toastr.warning t('Old_and_new_password_required')

		else if password == confirmPassword
			Accounts.changePassword oldPassword, password, (error) ->
				if error
					toastr.error t('Incorrect_Password')
				else
					toastr.success t('Password_changed_successfully')
					instance.clearForm();
					return callback()
		else
			toastr.error t('Confirm_Password_Not_Match')


	@saveProfile = ->
		instance = @
		reload = false
		data = {}

		selectedLanguage = $('#language').val()

		if localStorage.getItem('userLanguage') isnt selectedLanguage
			localStorage.setItem 'userLanguage', selectedLanguage
			data.language = selectedLanguage
			reload = true

		# if _.trim $('#username').val()
		# 	data.username = _.trim $('#username').val()

		if _.trim $('#name').val()
			data.name = _.trim $('#name').val()

		Meteor.call 'saveUserProfile', data, (error, results) ->
			if results
				toastr.success t('Profile_saved_successfully')
				instance.clearForm()
				if reload
					setTimeout ->
						Meteor._reload.reload()
					, 1000

			if error
				toastr.error error.reason



		
Template.profile.events
	'click #saveProfile': (e, t) ->
		t.saveProfile()

	'click #changePassword': (e, t) ->
		t.changePassword()

