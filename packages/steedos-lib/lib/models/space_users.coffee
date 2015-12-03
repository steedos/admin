db.space_users = new Meteor.Collection('space_users')

db.space_users.permit(['insert', 'update', 'remove']).apply();

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
			type: "select2",
			options: ->
				options = [{
					label: "",
					value: ""
				}]
				objs = db.organizations.find({}, 
					{
						sort: {name:1}
					}
				)
				objs.forEach (obj) ->
					options.push({
						label: obj.name,
						value: obj._id
					})
				return options

	manager: 
		type: String,
		optional: true,
		autoform:
			type: "select2"
			options: ->
				options = [
						value: null
						label: ""
				]
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


db.space_users._selector = (userId, connection) ->
	if Meteor.isServer
		# user = db.users.findOne({_id: userId})
		# if user
		# 	return {space: {$in: user.spaces()}}
		# else 
		# 	return {}
		spaceId = connection["spaceId"]
		console.log "[selector] filter space_users " + spaceId
		if spaceId
			return {space: spaceId}
		else
			return {space: "-1"}
	#if Meteor.isClient
		#if (Session.get("spaceId"))
		#	return {space: Session.get("spaceId")}
		#else 
		#	return {}


if (Meteor.isClient) 

	db.space_users.helpers
		space_name: ->
			space = db.spaces.findOne({_id: this.space});
			return space?.name
		

if (Meteor.isServer) 


	db.space_users.before.insert (userId, doc) ->
		doc.created_by = userId;
		doc.created = new Date();

		if (!doc.space)
			throw new Meteor.Error(400, t("user_spaces_error.space_is_required"));

		if (!doc.user && doc.email)
			userObj = db.users.findOne({"emails.address": doc.email});
			if (userObj)
				doc.user = userObj._id
				doc.name = userObj.name

		if (!doc.user)
			throw new Meteor.Error(400, t("user_spaces_error.user_is_required"));

		if (!doc.name)
			throw new Meteor.Error(400, t("user_spaces_error.name_is_required"));

	db.space_users.before.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		if (modifier.$set.email)
			throw new Meteor.Error(400, t("user_spaces_error.can_not_modify_email"));
		if (modifier.$set.space)
			throw new Meteor.Error(400, t("user_spaces_error.can_not_modify_space"));
		if (modifier.$set.user)
			throw new Meteor.Error(400, t("user_spaces_error.can_not_modify_user"));
	
	Steedos.api.addCollection db.space_users	

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
	