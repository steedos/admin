Template.profile.helpers
	setChecked: (value, currentValue) ->
	    if(value == currentValue) 
	       return "checked"
	    else 
	       return ""

	getGravatarURL: (user, size) ->
		if (Meteor.user())
			return Meteor.user().avatar

	user: ->
		return Meteor.user()

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

		
Template.profile.events
	'click #saveProfile': (e, t) ->
		t.save()

	'click #changePassword': (e, t) ->
		t.changePassword()

