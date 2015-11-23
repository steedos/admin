Steedos.SpaceUsers = new Meteor.Collection('space_users')

Steedos.SpaceUsers.permit(['insert', 'update', 'remove']).apply();

Steedos.SpaceUsers._simpleSchema = new SimpleSchema({
	space: {
		type: String,
	},
	user: {
		type: String,
		optional: true,
	},
	name: {
		type: String,
		max: 50
	},
	email: {
		type: String,
		regEx: SimpleSchema.RegEx.Email,
		max: 200
	},
});

Steedos.SpaceUsers._table = new Tabular.Table({
	name: "SpaceUsers",
	collection: Steedos.SpaceUsers,
	lengthChange: false,
	select: {
		style: 'single'
	},
	columns: [
		{data: "name"},
		{data: "email"},
	],
});
	
Steedos.collections.SpaceUsers = Steedos.SpaceUsers