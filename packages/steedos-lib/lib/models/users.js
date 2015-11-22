Steedos.Users = Meteor.users;

Steedos.Users.permit(['insert', 'update', 'remove']).apply();

Steedos.Users._schema = new SimpleSchema({
	name: {
		type: String,
		max: 50
	},
	username: {
		type: String,
		optional: true
	},
	email: {
		type: String,
		regEx: SimpleSchema.RegEx.Email,
		max: 200
	},
	company: {
		type: String,
		optional: true,
		max: 200
	},
	mobile: {
		type: String,
		optional: true,
		max: 200
	},
	locale: {
		type: String,
		optional: true,
		allowedValues: [
			"en-us",
			"zh-cn"
		],
		autoform: {
			//type: "select-radio",
			options: [{
				label: "Chinese",
				value: "zh-cn"
			},
			{
				label: "English",
				value: "en-us"
			}]
		}
	},
	timezone: {
		type: String,
		optional: true,
		max: 1000
	},
	// "services.resume.loginTokens": {
	// 	type: [Object],
	// 	optional: true,
	// }
});

Steedos.Users._table = new Tabular.Table({
	name: "Users",
	collection: Steedos.Users,
	lengthChange: false,
	select: {
		style: 'single'
	},
	columns: [
		{data: "name"},
		{data: "email"},
		{data: "locale"}
	],
});
	