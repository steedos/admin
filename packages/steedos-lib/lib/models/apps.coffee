Steedos.collections.Apps = new Meteor.Collection 'apps'

Steedos.collections.Apps.permit(['insert', 'update', 'remove']).apply();


Steedos.collections.Apps.attachSchema(new SimpleSchema({
	name: {
		type: String,
		label: t("Apps_Name"),
		max: 50
	},
	description: {
		type: String,
		label: t("Apps_Description"),
		max: 200
	},
	url: {
		type: String,
		label: t("Apps_URL"),
		max: 200
	},
	iconURL: {
		type: String,
		label: t("Apps_IconURL"),
		optional: true,
		max: 1000
	}
}));

Steedos.tables.Apps = new Tabular.Table({
	name: "Apps",
	collection: Steedos.collections.Apps,
	lengthChange: false,
	select: {
		style: 'single'
	},
	columns: [
		{data: "name", title: t("Apps_Name")},
		{data: "description", title: t("Apps_Description")},
		{data: "url", title: t("Apps_URL")}
	]
});