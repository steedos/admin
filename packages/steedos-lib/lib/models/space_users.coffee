db.space_users = new Meteor.Collection('space_users')

db.space_users._simpleSchema = new SimpleSchema
	space: 
		type: String,
		autoform: 
			type: "hidden",
			defaultValue: ->
				return Session.get("spaceId");
	name: 
		type: String,
		max: 50,
		optional: true,
	email:
		type: String,
		regEx: SimpleSchema.RegEx.Email,
		optional: true,
	user:
		type: String,
		optional: true,
		autoform:
			omit: true
	organization: 
		type: String,
		optional: true,
		autoform: 
			omit: true
			# type: "select2",
			# options: ->
			# 	options = [{
			# 		label: " - ",
			# 		value: ""
			# 	}]
			# 	objs = db.organizations.find({}, 
			# 		{
			# 			sort: {fullname:1}
			# 		}
			# 	)
			# 	objs.forEach (obj) ->
			# 		options.push({
			# 			label: obj.fullname,
			# 			value: obj._id
			# 		})
			# 	return options

	manager: 
		type: String,
		optional: true,
		autoform:
			type: "select2"
			options: ->
				options = [{
					label: " - ",
					value: ""
				}]
				selector = {}
				if Session.get("spaceId")
					selector = {space: Session.get("spaceId")}

				objs = db.space_users.find(selector, {name:1, sort: {name:1}})
				objs.forEach (obj) ->
					options.push
						label: obj.name,
						value: obj.user
				return options

	user_accepted: 
		type: Boolean,
		optional: true,
	created:
		type: Date,
		optional: true
		autoform:
			omit: true
	created_by:
		type: String,
		optional: true
		autoform:
			omit: true
	modified:
		type: Date,
		optional: true
		autoform:
			omit: true
	modified_by:
		type: String,
		optional: true
		autoform:
			omit: true

if Meteor.isClient
	db.space_users._simpleSchema.i18n("db.space_users")

db.space_users.attachSchema(db.space_users._simpleSchema);

db.space_users.adminConfig = 
		icon: "users"
		label: ->
			return t("db.space_users")
		tableColumns: [
			{name: "name"},
			{name: "organization_name()"},
			{name: "space_name()"},
		]
		extraFields: ["space", "user", 'organization']
		newFormFields: "space,email"
		editFormFields: "space,name,manager,user_accepted"
		selector: (userId, connection) ->
			if Meteor.isServer
				spaceId = connection["spaceId"]
				console.log "[selector] filter space_users " + spaceId
				if spaceId
					return {space: spaceId}
				else
					return {space: "-1"}


db.space_users.helpers
	space_name: ->
		space = db.spaces.findOne({_id: this.space});
		return space?.name
	organization_name: ->
		organization = db.organizations.findOne({_id: this.organization});
		return organization?.name


if (Meteor.isServer) 


	db.space_users.before.insert (userId, doc) ->
		doc.created_by = userId;
		doc.created = new Date();

		if !doc.space
			throw new Meteor.Error(400, t("space_users_error.space_required"));

		# check space exists
		space = db.spaces.findOne(doc.space)
		if !space
			throw new Meteor.Error(400, t("space_users_error.space_not_found"));
		if space.admins.indexOf(userId) < 0 and not Roles.userIsInRole userId, "admin"
			throw new Meteor.Error(400, t("space_users_error.space_admins_only"));
			
		if !doc.user && doc.email
			userObj = db.users.findOne({"emails.address": doc.email});
			if (userObj)
				doc.user = userObj._id
				doc.name = userObj.name
			else
				user = {email: doc.email}
				doc.user = Accounts.createUser user
				doc.name = doc.email.split('@')[0]

		if !doc.user
			throw new Meteor.Error(400, t("space_users_error.user_required"));

		if !doc.name
			throw new Meteor.Error(400, t("space_users_error.name_required"));

	db.space_users.before.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};

		# check space exists
		space = db.spaces.findOne(doc.space)
		if !space
			throw new Meteor.Error(400, t("space_users_error.space_not_found"));
		# only space admin can update space_users
		if space.admins.indexOf(userId) < 0 and not Roles.userIsInRole userId, "admin"
			throw new Meteor.Error(400, t("space_users_error.space_admins_only"));

		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		if modifier.$set.email
			if modifier.$set.email != doc.email
				throw new Meteor.Error(400, t("space_users_error.email_readonly"));
		if modifier.$set.space
			if modifier.$set.space != doc.space
				throw new Meteor.Error(400, t("space_users_error.space_readonly"));
		if modifier.$set.user
			if modifier.$set.user != doc.user
				throw new Meteor.Error(400, t("space_users_error.user_readonly"));
	
	db.space_users.before.remove (userId, doc) ->
		# check space exists
		space = db.spaces.findOne(doc.space)
		if !space
			throw new Meteor.Error(400, t("space_users_error.space_not_found"));
		# only space admin can remove space_users
		if space.admins.indexOf(userId) < 0
			throw new Meteor.Error(400, t("space_users_error.space_admins_only"));


	Meteor.publish 'space_users', (spaceId)->
		unless this.userId
			return this.ready()

		user = db.users.findOne(this.userId);

		selector = {}
		if spaceId
			selector.space = spaceId
		else 
			selector.space = {$in: user.spaces()}

		console.log '[publish] space_users ' + spaceId

		return db.space_users.find(selector)
	