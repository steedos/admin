Steedos.Spaces = new Meteor.Collection('spaces', {idGeneration: "MONGO"})

Steedos.Spaces.permit(['insert', 'update', 'remove']).apply();

Steedos.Spaces.attachSchema(new SimpleSchema({
	name: {
		type: String,
  		unique: true,
		max: 200
	},	
	// 第一个管理员就是owner
	owner: {
		type: String,
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
		autoform: {
			type: "select2",
			afFieldInput: {
				multiple: true
			},
			options: function() {
				options = []
				objs = Steedos.Users.find({}, {name:1, sort: {name:1}})
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
	balance: {
		type: Number,
		optional: true,
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

	google_domain_name: {
		type: String,
		optional: true,
	},
	imo_cid: {
		type: String,
		optional: true,
	},
}));

Steedos.Spaces._table = new Tabular.Table({
	name: "Spaces",
	collection: Steedos.Spaces,
	lengthChange: false,
	select: {
		style: 'single'
	},
	columns: [
		{data: "name"},
		{data: "owner"},
		{data: "admins"},
		{data: "is_paid"},
	],
	extraFields: ["balance"],
});
	
Steedos.collections.Spaces = Steedos.Spaces