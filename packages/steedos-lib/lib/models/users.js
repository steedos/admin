Steedos.collections.Users = Meteor.users;

Steedos.collections.Users.permit(['insert', 'update', 'remove']).apply();

debugger;

Steedos.collections.Users.attachSchema(new SimpleSchema({
	name: {
		type: String,
		label: t("Users_Name"),
		max: 50
	},
	username: {
		type: String,
		label: t("Users_Username"),
		optional: true
	},
	email: {
		type: String,
		label: t("Users_Email"),
		regEx: SimpleSchema.RegEx.Email,
		max: 200
	},
	company: {
		type: String,
		label: t("Users_Company"),
		optional: true,
		max: 200
	},
	mobile: {
		type: String,
		label: t("Users_Mobile"),
		optional: true,
		max: 200
	},
	locale: {
		type: String,
		label: t("Users_Locale"),
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
		label: t("Users_Timezone"),
		optional: true,
		max: 1000
	},
}));

Steedos.tables.Users = new Tabular.Table({
	name: "Users",
	collection: Steedos.collections.Users,
	lengthChange: false,
	select: {
		style: 'single'
	},
	columns: [
		{data: "name", title: t("Users_Name")},
		{data: "email", title: t("Users_Email")},
		{data: "locale", title: t("Users_Locale")}
	]
});