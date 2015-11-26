db.spaces = new Meteor.Collection('spaces')

db.spaces.permit(['insert', 'update', 'remove']).apply();

db.spaces.attachSchema new SimpleSchema
	name: 
		type: String,
		unique: true,
		max: 200
	owner: 
		type: String,
		autoform:
			type: "select2",
			options: ->
				options = [{
					label: "",
					value: ""
				}]
				objs = db.users.find({}, {name:1, sort: {name:1}})
				objs.forEach (obj) ->
					options.push
						label: obj.name,
						value: obj._id

				return options

			defaultValue: ->
				return Meteor.userId

	admins: 
		type: [String],
		optional: true,
		autoform: 
			type: "select2",
			afFieldInput: 
				multiple: true
			options: ->
				options = []
				objs = db.users.find({}, {name:1, sort: {name:1}})
				objs.forEach (obj) ->
					options.push
						label: obj.name,
						value: obj._id
				return options
			
	balance: 
		type: Number,
		optional: true,
	is_paid: 
		type: Boolean,
		label: t("Spaces_isPaid"),
		optional: true,
		autoform:
			readonly: true
		# 余额>0为已付费用户
		autoValue: ->
			balance = this.field("balance")
			if (balance.isSet)
				return balance.value>0
			else
				this.unset()


# db.spaces._table = new Tabular.Table
# 	name: "Spaces",
# 	collection: db.spaces,
# 	lengthChange: false,
# 	select: 
# 		style: 'single',
# 		info: false
# 	columns: [
# 		{data: "name"},
# 		{data: "owner_name()"},
# 		{data: "admins_name()"},
# 		{data: "is_paid"},
# 	],
# 	extraFields: ["owner", "admins", "balance"],


if (Meteor.isClient) 

	db.spaces.helpers

		owner_name: ->
			owner = db.users.findOne({_id: this.owner});
			return owner && owner.name;
		
		admins_name: ->
			if (!this.admins)
				return ""
			admins = db.users.find({_id: {$in: this.admins}}, {fields: {name:1}});
			adminNames = []
			admins.forEach (admin) ->
				adminNames.push(admin.name)
			return adminNames.toString();
		

if (Meteor.isServer) 

	db.spaces.before.insert (userId, doc) ->
		doc.created_by = userId;
		doc.created = new Date();
		# 自动添加 Owner 为管理员
		if (doc.owner)
			if (!doc.admins)
				doc.admins = [doc.owner]
			if (doc.admins.indexOf(doc.owner) <0)
				doc.admins.push(doc.owner)


	db.spaces.after.insert (userId, doc) ->
		if (doc.admins)
			_.each doc.admins, (admin) ->
				db.space_users.add(admin, doc._id, true)
			

	db.spaces.before.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		# 自动添加 Owner 为管理员
		if (modifier.$set.owner)
			if (!modifier.$set.admins)
				modifier.$set.admins = [modifier.$set.owner]
			if (modifier.$set.admins.indexOf(modifier.$set.owner) <0)
				modifier.$set.admins.push(modifier.$set.owner)

	db.spaces.before.remove (userId, doc) ->
		db.space_users.remove({space: doc._id});