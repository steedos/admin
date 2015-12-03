Template.profile.helpers

	schema: ->
		return db.users._simpleSchema;

	user: ->
		return db.users.findOne(Meteor.userId())

	userId: ->
		return Meteor.userId()

	getGravatarURL: (user, size) ->
		if (Meteor.user())
			if Meteor.user().avatar
				return "/api/files/avatars/" + Meteor.user().avatar
			else
				return "/avatar/" + Meteor.user().emails[0].address


Template.profile.onRendered ->

    $('select.dropdown').dropdown()

Template.profile.onCreated ->

	AutoForm.hooks
		updateProfile:
			onSuccess: (formType, result) ->
				toastr.success t('Profile_saved_successfully')
				if this.updateDoc.$set.locale != this.currentDoc.locale
					toastr.success t('Language_changed_reloading')
					setTimeout ->
						Meteor._reload.reload()
					, 1000

			onError: (formType, error) ->
				toastr.error error
			

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

		
Template.profile.events

	'click .change-password': (e, t) ->
		t.changePassword()

	'change .avatar-file': (event, template) ->
		files = event.target.files;
		_.each files, (file) ->
			db.avatars.insert file,  (err, fileObj) ->
				# Inserted new doc with ID fileObj._id, and kicked off the data upload using HTTP
				Meteor.call "saveUserProfile", 
					avatar: fileObj._id
			