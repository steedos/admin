db.space_users = new Meteor.Collection('space_users')

db.space_users.permit(['insert', 'update', 'remove']).apply();

db.space_users._simpleSchema = new SimpleSchema
	space: 
		type: String,
		autoform: 
			type: "hidden",
			defaultValue: ->
				return Session.get("spaceId");
	email:
		type: String,
		regEx: SimpleSchema.RegEx.Email,
		optional: true,
	user:
		type: String,
		optional: true,
	name: 
		type: String,
		max: 50,
		optional: true,
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
	user_accepted: 
		type: Boolean,
		optional: true,
	manager: 
		type: String,
		optional: true,


db.space_users.attachSchema(db.space_users._simpleSchema);

# db.space_users._table = new Tabular.Table
# 	name: "SpaceUsers",
# 	collection: db.space_users,
# 	lengthChange: false,
# 	select: 
# 		style: 'single',
# 		info: false
# 	columns: [
# 		{data: "name"},
# 		{data: "email"},
# 		{data: "organization"},
# 		{data: "user_accepted"}
# 	],
# 	extraFields: ["user", "name", "space", "manager"],
# 	clientSelector: ->
# 		spaceId = Session.get("spaceId")
# 		if (spaceId)
# 			return {space: spaceId}
# 		return {}


if (Meteor.isServer) 

	db.space_users.add = (userId, spaceId, user_accepted) ->
		spaceUserObj = db.space_users.findOne({user: userId, space: spaceId})
		spaceObj = db.spaces.findOne(spaceId);
		userObj = db.users.findOne(userId);
		if (!userObj)
			return;
		if (!spaceObj)
			return;
		if (spaceUserObj)
			db.space_users.update spaceUserObj._id, 
				name: userObj.name,
				email: userObj.email,
				space: spaceObj._id,
				user_accepted: user_accepted
		else 
			db.space_users.insert
				name: userObj.name,
				email: userObj.email,
				space: spaceObj._id,
				user_accepted: user_accepted


	db.space_users.before.insert (userId, doc) ->
		doc.created_by = userId;
		doc.created = new Date();

		userObj = db.users.findOne({"emails.address": doc.email});
		if (userObj)
			doc.user = userObj._id


	db.space_users.before.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		if (modifier.$set.email)
			userObj = db.users.findOne({"emails.address": modifier.$set.email});
			if (userObj)
				modifier.$set.user = userObj._id
		
	