Steedos.Spaces = new Meteor.Collection('spaces')

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
		autoform: {
			type: "select2",
			options: function() {
				options = [{
					label: "",
					value: ""
				}]
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

}));

Steedos.Spaces._table = new Tabular.Table({
	name: "Spaces",
	collection: Steedos.Spaces,
	lengthChange: false,
	select: {
		style: 'single',
		info: false
	},
	columns: [
		{data: "name"},
		{data: "owner_name()"},
		{data: "admins_name()"},
		{data: "is_paid"},
	],
	extraFields: ["owner", "admins", "balance"],
	// clientSelector: function() {
	// 	spaceId = Session.get("spaceId")
	// 	if (spaceId)
	// 		return {_id: spaceId}
	// 	return {}
	// },
});
	
Steedos.collections.Spaces = Steedos.Spaces


if (Meteor.isClient) {
	Steedos.Spaces.helpers({
		owner_name: function(){
			owner = Steedos.Users.findOne({_id: this.owner});
			return owner && owner.name;
		},
		admins_name: function(){
			if (!this.admins)
				return ""
			admins = Steedos.Users.find({_id: {$in: this.admins}}, {fields: {name:1}});
			adminNames = []
			admins.forEach(function(admin){
				adminNames.push(admin.name)
			})
			return adminNames.toString();
		}
	})
}

if (Meteor.isServer) {

	Steedos.Spaces.before.insert(function(userId, doc){
		doc.created_by = userId;
		doc.created = new Date();

		// 自动添加 Owner 为管理员
		if (doc.owner)
		{
			if (!doc.admins)
				doc.admins = [doc.owner]
			if (doc.admins.indexOf(doc.owner) <0)
				doc.admins.push(doc.owner)
		}
	});

	Steedos.Spaces.before.update(function(userId, doc, fieldNames, modifier, options){
		modifier.$set = modifier.$set || {};
		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		// 自动添加 Owner 为管理员
		if (modifier.$set.owner)
		{
			if (!modifier.$set.admins)
				modifier.$set.admins = [modifier.$set.owner]
			if (modifier.$set.admins.indexOf(modifier.$set.owner) <0)
				modifier.$set.admins.push(modifier.$set.owner)
		}

	});
}