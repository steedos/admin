db.spaces = new Meteor.Collection('spaces')

db.spaces.permit(['insert', 'update', 'remove']).apply();

db.spaces.attachSchema(new SimpleSchema({
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
				objs = db.users.find({}, {name:1, sort: {name:1}})
				objs.forEach(function(obj){
					options.push({
						label: obj.name,
						value: obj._id
					})
				});
				return options
			},
			defaultValue: function(){
				return Meteor.userId
			}
		}
	},
	admins: {
		type: [String],
		optional: true,
		autoform: {
			type: "select2",
			afFieldInput: {
				multiple: true
			},
			options: function() {
				options = []
				objs = db.users.find({}, {name:1, sort: {name:1}})
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

db.spaces._table = new Tabular.Table({
	name: "Spaces",
	collection: db.spaces,
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
	


if (Meteor.isClient) {
	db.spaces.helpers({
		owner_name: function(){
			owner = db.users.findOne({_id: this.owner});
			return owner && owner.name;
		},
		admins_name: function(){
			if (!this.admins)
				return ""
			admins = db.users.find({_id: {$in: this.admins}}, {fields: {name:1}});
			adminNames = []
			admins.forEach(function(admin){
				adminNames.push(admin.name)
			})
			return adminNames.toString();
		}
	})
}

if (Meteor.isServer) {

	db.spaces.before.insert(function(userId, doc){
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

	db.spaces.after.insert(function(userId, doc){
		if (doc.admins)
			_.each(doc.admins, function(admin){
				db.space_users.add(admin, doc._id, true)
			})
	});

	db.spaces.before.update(function(userId, doc, fieldNames, modifier, options){
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