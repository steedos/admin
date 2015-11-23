Steedos.Apps = new Meteor.Collection('apps')

Steedos.Apps.permit(['insert', 'update', 'remove']).apply();

Steedos.Apps.attachSchema(new SimpleSchema({
	name: {
		type: String,
		max: 50
	},
	description: {
		type: String,
		max: 200
	},
	url: {
		type: String,
		max: 200
	},
	iconURL: {
		type: String,
		optional: true,
		max: 1000
	}
}));

Steedos.Apps._table = new Tabular.Table({
	name: "Apps",
	collection: Steedos.Apps,
	lengthChange: false,
	select: {
		style: 'single'
	},
	columns: [
		{data: "name"},
		{data: "description"},
		{data: "url"}
	],
	extraFields: ["iconURL"],
	// Filter data by permission
	// selector: function() {
	// 	return {}
	// },
	
});

Steedos.collections.Apps = Steedos.Apps