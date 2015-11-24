Steedos.Users = Meteor.users;

Steedos.Users.permit(['insert', 'update', 'remove']).apply();

Steedos.Users._simpleSchema = new SimpleSchema
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
	steedos_id: 
		type: String,
		optional: true
	last_logon:
		type: Date
		optional: true
	email_notification:
		type: Boolean
		optional: true
	is_cloudadmin:
		type: Boolean
		optional: true


Steedos.Users._table = new Tabular.Table
	name: "Users",
	collection: Steedos.Users,
	lengthChange: false,
	select: 
		style: 'single',
		info: false
	columns: [
		{data: "name"},
		{data: "email"},
		{data: "locale"}
	],

Steedos.collections.Users = Steedos.Users


if Meteor.isServer

	Steedos.Users.checkEmailValid = (email) ->
		existed = Steedos.Users.find 
			"emails.address": email
		if existed.count()>0
			throw new Meteor.Error(400, t("users_error.email_exists"));

	Steedos.Users.checkUsernameValid = (username) ->
		existed = Steedos.Users.find 
			"username": email
		if existed.count()>0
			throw new Meteor.Error(400, t("users_error.username_exists"));

	Steedos.Users.before.insert (userId, doc) ->
		doc.created_by = userId;
		doc.created = new Date();

		if (doc.email && !doc.emails)
			doc.emails = []
			doc.emails.push
				address: doc.email,
				verified: !!doc.primary_email_verified
		if (doc.email && !doc.steedos_id)
			doc.steedos_id = doc.email

		_.each doc.emails, (obj)->
			Steedos.Users.checkEmailValid(obj.address);
		

	Steedos.Users.before.update  (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();
