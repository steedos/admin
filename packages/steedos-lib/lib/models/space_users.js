Steedos.SpaceUsers = new Meteor.Collection('space_users')

Steedos.SpaceUsers.permit(['insert', 'update', 'remove']).apply();

Steedos.SpaceUsers._simpleSchema = new SimpleSchema({
	space: {
		type: String,
		autoform: {
			type: "select2",
			options: function() {
				options = [{
					label: "",
					value: ""
				}]
				objs = Steedos.Spaces.find({}, 
					{
						fields: {name: 1}, 
						sort: {name:1}
					}
				)
				objs.forEach(function(obj){
					options.push({
						label: obj.name,
						value: obj._id
					})
				});
				return options
			}
		}
	},
	email: {
		type: String,
		regEx: SimpleSchema.RegEx.Email,
		max: 200
	},
	user: {
		type: String,
		optional: true,
	},
	name: {
		type: String,
		max: 50,
		optional: true,
	},
	organization: {
		type: String,
		autoform: {
			type: "select2",
			options: function() {
				options = [{
					label: "",
					value: ""
				}]
				objs = Steedos.Organizations.find({}, 
					{
						fields: {name: 1}, 
						sort: {name:1}
					}
				)
				objs.forEach(function(obj){
					options.push({
						label: obj.name,
						value: obj._id
					})
				});
				return options
			}
		}
	},
	user_accepted: {
		type: Boolean,
		optional: true,
	},
	manager: {
		type: String,
		optional: true,
	},
});
Steedos.SpaceUsers.attachSchema(Steedos.SpaceUsers._simpleSchema);

Steedos.SpaceUsers._table = new Tabular.Table({
	name: "SpaceUsers",
	collection: Steedos.SpaceUsers,
	lengthChange: false,
	select: {
		style: 'single',
		info: false
	},
	columns: [
		{data: "name"},
		{data: "email"},
		{data: "organization"},
		{data: "user_accepted"}
	],
	extraFields: ["user", "name", "space", "manager"]
});
	
Steedos.collections.SpaceUsers = Steedos.SpaceUsers


if (Meteor.isServer) {

	Steedos.SpaceUsers.before.insert(function(userId, doc){
		doc.created_by = userId;
		doc.created = new Date();

		userObj = Steedos.Users.findOne({"emails.address": doc.email});
		if (userObj)
			doc.user = userObj._id

	});

	Steedos.SpaceUsers.before.update(function(userId, doc, fieldNames, modifier, options){
		modifier.$set = modifier.$set || {};
		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		if (modifier.$set.email){
			userObj = Steedos.Users.findOne({"emails.address": modifier.$set.email});
			if (userObj)
				modifier.$set.user = userObj._id
		}
	});
}