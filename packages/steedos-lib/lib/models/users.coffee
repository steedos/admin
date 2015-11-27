db.users = Meteor.users;

db.users.permit(['insert', 'update', 'remove']).apply();

db.users._simpleSchema = new SimpleSchema
	name: 
		type: String,
	username: 
		type: String,
		optional: true
	email: 
		type: String,
		regEx: SimpleSchema.RegEx.Email,
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
			options: ->
				if Meteor.isClient
					return Steedos._timezones

	primary_email_verified:
		type: Boolean
		optional: true
		autoform:
			readonly: true
	steedos_id: 
		type: String,
		optional: true
		autoform:
			readonly: true
	last_logon:
		type: Date
		optional: true
		autoform:
			readonly: true
	email_notification:
		type: Boolean
		optional: true
	is_cloudadmin:
		type: Boolean
		optional: true


db.users.helpers
	spaces: ->
		spaces = []
		if this.space
			sus = db.space_users.find({user: this._id}, {fields: {_id:1}})
			sus.forEach (su) ->
				spaces.push(su._id)
		return spaces;

if Meteor.isClient
	
	db.users.helpers
		displayName: ->
			if this.name 
				return this.name
			else if this.emails[0]
				return this.emails[0].address
		

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

		if (doc.email && !doc.emails)
			doc.emails = []
			doc.emails.push
				address: doc.email,
				verified: !!doc.primary_email_verified
		else if (doc.emails && !doc.email)
			if doc.emails.length>0
				doc.email = doc.emails[0].address

		if (doc.profile?.name && !doc.name)
			doc.name = doc.profile.name

		if (doc.email && !doc.steedos_id)
			doc.steedos_id = doc.email

		_.each doc.emails, (obj)->
			db.users.checkEmailValid(obj.address);
		

	db.users.before.update  (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		if userId
			modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();
