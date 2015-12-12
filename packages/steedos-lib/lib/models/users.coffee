db.users = Meteor.users;

db.users.allow
	# Allow user update own profile
	update: (userId, doc, fields, modifier) ->
		if userId == doc._id
			return true

db.users._simpleSchema = new SimpleSchema
	name: 
		type: String,
	username: 
		type: String,
		unique: true,
		optional: true
	steedos_id: 
		type: String,
		optional: true
		unique: true,
		autoform: 
			type: "text"
			readonly: true
	company: 
		type: String,
		optional: true,
	mobile: 
		type: String,
		optional: true,
	locale: 
		type: String,
		optional: true,
		allowedValues: [
			"en-us",
			"zh-cn"
		],
		autoform: 
			type: "select2",
			options: [{
				label: "Chinese",
				value: "zh-cn"
			},
			{
				label: "English",
				value: "en-us"
			}]
	timezone: 
		type: String,
		optional: true,
		autoform:
			type: "select2",
			options: ->
				if Meteor.isClient
					return Steedos._timezones

	email_notification:
		type: Boolean
		optional: true

	primary_email_verified:
		type: Boolean
		optional: true
		autoform: 
			omit: true
	last_logon:
		type: Date
		optional: true
		autoform: 
			omit: true
	is_cloudadmin:
		type: Boolean
		optional: true
		autoform: 
			omit: true

if Meteor.isClient
	db.users._simpleSchema.i18n("db.users")

db.users.helpers
	spaces: ->
		spaces = []
		sus = db.space_users.find({user: this._id}, {fields: {space:1}})
		sus.forEach (su) ->
			spaces.push(su.space)
		return spaces;

	displayName: ->
		if this.name 
			return this.name
		else if this.username
			return this.username
		else if this.emails[0]
			return this.emails[0].address

	avatarURL: ->
		if this.avatar
			return "/api/files/avatars/" + this.avatar
		else if this.username
			return "/avatar/" + this.username
		else if this.emails && this.emails.length>0
			return "/avatar/" + this.emails[0].address


if Meteor.isServer

		
	db.users.checkEmailValid = (email) ->
		existed = db.users.find 
			"emails.address": email
		if existed.count()>0
			throw new Meteor.Error(400, t("users_error.email_exists"));

	db.users.checkUsernameValid = (username) ->
		existed = db.users.find 
			"username": email
		if existed.count()>0
			throw new Meteor.Error(400, t("users_error.username_exists"));

	db.users.before.insert (userId, doc) ->

		if userId
			doc.created_by = userId;
			doc.created = new Date();

		if (doc.emails && !doc.steedos_id)
			if doc.emails.length>0
				doc.steedos_id = doc.emails[0].address

		if (doc.profile?.name && !doc.name)
			doc.name = doc.profile.name

		if (doc.steedos_id && !doc.name)
			doc.name = doc.steedos_id.split('@')[0]

		if (doc.steedos_id && !doc.username)
			doc.username = doc.steedos_id.replace("@","_").replace(".","_")

		_.each doc.emails, (obj)->
			db.users.checkEmailValid(obj.address);
		

	db.users.before.update  (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};

		if doc.steedos_id && modifier.$set.steedos_id
			if modifier.$set.steedos_id != doc.steedos_id
				throw new Meteor.Error(400, t("users_error.steedos_id_readonly"));

		if userId
			modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();


	db.users.after.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		if modifier.$set.name
			db.space_users.direct.update({user: doc._id}, {$set: {name: modifier.$set.name}}, {multi: true})


	db.users.before.remove (userId, doc) ->
		if not Roles.userIsInRole userId, "admin"
			throw new Meteor.Error(400, t("users_error.cloud_admin_required"));

	Meteor.publish 'userData', ->
		unless this.userId
			return this.ready()

		console.log '[publish] userData'

		db.users.find this.userId,
			fields:
				steedos_id: 1
				name: 1
				company: 1
				mobile: 1
				avatar: 1
				locale: 1
				timezone: 1
				username: 1
				utcOffset: 1
				settings: 1
				is_cloudadmin: 1
