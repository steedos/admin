Steedos.models.Users = new class extends Steedos.models._Base
	constructor: ->
		@model = Meteor.users


	# FIND ONE
	findOneById: (_id, options) ->
		return @findOne _id, options

	findOneByUsername: (username, options) ->
		query =
			username: username

		return @findOne query, options

	findOneByEmailAddress: (emailAddress, options) ->
		query =
			'emails.address': emailAddress

		return @findOne query, options

	findOneByVerifiedEmailAddress: (emailAddress, verified=true, options) ->
		query =
			emails:
				$elemMatch:
					address: emailAddress
					verified: verified

		return @findOne query, options

	findOneAdmin: (admin, options) ->
		query =
			admin: admin

		return @findOne query, options


	# FIND
	findUsersNotOffline: (options) ->
		query =
			username:
				$exists: 1
			status:
				$in: ['online', 'away', 'busy']

		return @find query, options


	findByUsername: (username, options) ->
		query =
			username: username

		return @find query, options

	findUsersByNameOrUsername: (nameOrUsername, options) ->
		query =
			username:
				$exists: 1

			$or: [
				{name: nameOrUsername}
				{username: nameOrUsername}
			]

		return @find query, options

	findByUsernameNameOrEmailAddress: (usernameNameOrEmailAddress, options) ->
		query =
			$or: [
				{name: usernameNameOrEmailAddress}
				{username: usernameNameOrEmailAddress}
				{'emails.address': usernameNameOrEmailAddress}
			]

		return @find query, options


	# UPDATE
	updateLastLoginById: (_id) ->
		update =
			$set:
				lastLogin: new Date

		return @update _id, update

	setServiceId: (_id, serviceName, serviceId) ->
		update =
			$set: {}

		serviceIdKey = "services.#{serviceName}.id"
		update.$set[serviceIdKey] = serviceId

		return @update _id, update

	setUsername: (_id, username) ->
		update =
			$set: username: username

		return @update _id, update

	setEmail: (_id, email) ->
		update =
			$set: email: email

		return @update _id, update

	setName: (_id, name) ->
		update =
			$set:
				name: name

		return @update _id, update

	setCompany: (_id, company) ->
		update =
			$set:
				company: company

		return @update _id, update

	setMobile: (_id, mobile) ->
		update =
			$set:
				mobile: mobile

		return @update _id, update

	setAvatar: (_id, avatar) ->
		update =
			$set:
				avatar: avatar

		return @update _id, update

	setUserActive: (_id, active=true) ->
		update =
			$set:
				active: active

		return @update _id, update

	setAllUsersActive: (active) ->
		update =
			$set:
				active: active

		return @update {}, update, { multi: true }

	unsetLoginTokens: (_id) ->
		update =
			$set:
				"services.resume.loginTokens" : []

		return @update _id, update

	setLocale: (_id, locale) ->
		update =
			$set:
				locale: locale

		return @update _id, update

	setTimezone: (_id, timezone) ->
		update =
			$set:
				timezone: timezone

		return @update _id, update

	setProfile: (_id, profile) ->
		update =
			$set:
				"profile": profile

		return @update _id, update

	setPreferences: (_id, preferences) ->
		update =
			$set:
				"settings": preferences

		return @update _id, update

	setUtcOffset: (_id, utcOffset) ->
		query =
			_id: _id
			utcOffset:
				$ne: utcOffset

		update =
			$set:
				utcOffset: utcOffset

		return @update query, update


	# INSERT
	create: (data) ->
		user =
			createdAt: new Date

		_.extend user, data

		return @insert user


	# REMOVE
	removeById: (_id) ->
		return @remove _id

	removeByUnverifiedEmail: (email) ->
		query =
			emails:
				$elemMatch:
					address: email
					verified: false

		return @remove query
