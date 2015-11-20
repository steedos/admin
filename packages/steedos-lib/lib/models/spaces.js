Steedos.collections.Spaces = new Meteor.Collection('spaces')

Steedos.collections.Spaces.permit(['insert', 'update', 'remove']).apply();

Steedos.collections.Spaces.attachSchema(new SimpleSchema({
	name: {
		type: String,
		label: t("Spaces_Name"),
  		unique: true,
		max: 200
	},	
	// 第一个管理员就是owner
	owner: {
		type: String,
		label: t("Spaces_Owner"),
		autoValue: function(){
			var admins = this.field("admins");
			if (admins.isSet && admins.value.length>0) {
				return admins.value[0];
			} else {
				this.unset();
			}
		}
	},
	admins: {
		type: [String],
		label: t("Spaces_Admins"),
	},
	is_paid: {
		type: Boolean,
		label: t("Spaces_isPaid"),
		optional: true,
		// 余额>0为已付费用户
		autoValue: function(){
			var balance = this.field("balance")
			if (balance.isSet)
				return balance.value>0
			else
				this.unset()
		}
	},
	balance: {
		type: Number,
		label: t("Spaces_Balance"),
		optional: true,
	},

	google_domain_name: {
		type: String,
		label: t("Spaces_GoogleDomainName"),
		optional: true,
	},
	imo_cid: {
		type: String,
		label: t("Spaces_ImoCid"),
		optional: true,
	},
}));

Steedos.tables.Spaces = new Tabular.Table({
	name: "Spaces",
	collection: Steedos.collections.Spaces,
	lengthChange: false,
	select: {
		style: 'single'
	},
	columns: [
		{data: "name", title: t("Spaces_Name")},
		{data: "owner", title: t("Spaces_Owner")},
		{data: "admins", title: t("Spaces_Admins")},
		{data: "is_paid", title: t("Spaces_isPaid")},
	],
	extraFields: ["balance"]
});