db.users = Meteor.users;


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
			omit: true
	steedos_id: 
		type: String,
		optional: true
		autoform: 
			omit: true
	last_logon:
		type: Date
		optional: true
		autoform: 
			omit: true
	email_notification:
		type: Boolean
		optional: true
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

		if (doc.email && !doc.name)
			doc.name = doc.email.split('@')[0]

		if (doc.email && !doc.steedos_id)
			doc.steedos_id = doc.email

		_.each doc.emails, (obj)->
			db.users.checkEmailValid(obj.address);
		

	db.users.before.update  (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		if userId
			modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();


	db.users.after.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		if modifier.$set.name
			db.space_users.direct.update({user: doc._id}, {$set: {name: modifier.$set.name}}, {multi: true})
		if modifier.$set.email
			db.space_users.direct.update({user: doc._id}, {$set: {email: modifier.$set.email}}, {multi: true})



	Meteor.publish 'userData', ->
		unless this.userId
			return this.ready()

		console.log '[publish] userData'

		db.users.find this.userId,
			fields:
				name: 1
				email: 1
				company: 1
				mobile: 1
				avatar: 1
				locale: 1
				timezone: 1
				username: 1
				utcOffset: 1
				settings: 1
				is_cloudadmin: 1
