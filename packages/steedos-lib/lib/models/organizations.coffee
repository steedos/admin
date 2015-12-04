db.organizations = new Meteor.Collection('organizations')

db.organizations.permit(['insert', 'update', 'remove']).apply();

db.organizations._simpleSchema = new SimpleSchema
	space: 
		type: String,
		autoform: 
			type: "hidden",
			defaultValue: ->
				return Session.get("spaceId");
	name:
		type: String,
		max: 200
	parent:
		type: String,
		optional: true,
		autoform:
			type: "select2",
			options: ->
				options = [{
					label: "",
					value: ""
				}]
				objs = db.organizations.find({}, 
						{
							fields: {fullname: 1}, 
							sort: {fullname:1}
						})
				objs.forEach (obj) ->
					options.push({
						label: obj.fullname,
						value: obj._id
					})
				return options
	sort_no: 
		type: Number,
		optional: true,
		autoform: 
			omit: true
	users: 
		type: [String],
		optional: true,
		autoform: 
			omit: true
	is_company: 
		type: Boolean,
		optional: true,
		autoform: 
			omit: true
	parents: 
		type: [String],
		optional: true,
		autoform: 
			omit: true
	fullname: 
		type: String,
		optional: true,
		autoform: 
			omit: true
	children:
		type: [String],
		optional: true,
		autoform: 
			omit: true

if Meteor.isClient
	db.organizations._simpleSchema.i18n("db.organizations")

db.organizations.attachSchema db.organizations._simpleSchema;


db.organizations._selector = (userId) ->
	if Meteor.isServer
		user = db.users.findOne({_id: userId})
		if user
			return {space: {$in: user.spaces()}}
		else 
			return {}
	if Meteor.isClient
		if (Session.get("spaceId"))
			return {space: Session.get("spaceId")}
		else 
			return {}



db.organizations.helpers

	calculateParents: ->
		parents = [];
		if (!this.parent)
			return parents
		parentId = this.parent;
		while (parentId)
			parents.push(parentId)
			parentOrg = db.organizations.findOne({_id: parentId}, {parent: 1, name: 1});
			if (parentOrg)
				parentId = parentOrg.parent
		return parents


	calculateFullname: ->
		fullname = this.name;
		if (!this.parent)
			return fullname;
		parentId = this.parent;
		while (parentId)
			parentOrg = db.organizations.findOne({_id: parentId}, {parent: 1, name: 1});
			fullname = parentOrg.name + "/" + fullname;
			parentId = parentOrg.parent
		return fullname


	calculateChildren: ->
		children = []
		childrenObjs = db.organizations.find({parent: this._id}, {});
		childrenObjs.forEach (child) ->
			children.push(child._id);
		return children;


	space_name: ->
		space = db.spaces.findOne({_id: this.space});
		return space?.name
		

if (Meteor.isServer) 

	db.organizations.before.insert (userId, doc) ->
		doc.created_by = userId;
		doc.created = new Date();
		#doc.is_company = !doc.parent;


	db.organizations.before.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		if (modifier.$set.parent)
			# parent 不能等于自己或者children
			parentOrg = db.organizations.findOne({_id: modifier.$set.parent})
			if (doc._id == parentOrg._id || parentOrg.parents.indexOf(doc._id)>=0)
				throw new Meteor.Error(400, t("organizations_error.parent_is_self"));


	db.organizations.before.remove (userId, doc) ->
		if (doc.children && doc.children.length>0)
			throw new Meteor.Error(400, t("organizations_error.delete_with_children"));


	db.organizations.after.insert (userId, doc) ->
		updateFields = {}
		obj = db.organizations.findOne(doc._id)
		
		updateFields.parents = obj.calculateParents();
		updateFields.fullname = obj.calculateFullname()

		if !_.isEmpty(updateFields)
			db.organizations.direct.update(obj._id, {$set: updateFields})

		if (doc.parent)
			parent = db.organizations.findOne(doc.parent)
			db.organizations.direct.update(parent._id, {$set: {children: parent.calculateChildren()}});


	db.organizations.after.update (userId, doc, fieldNames, modifier, options) ->
		updateFields = {}
		obj = db.organizations.findOne(doc._id)
		if obj.parent
			updateFields.parents = obj.calculateParents();

		if (modifier.$set.parent)
			newParent = db.organizations.findOne(doc.parent)
			db.organizations.direct.update(newParent._id, {$set: {children: newParent.calculateChildren()}});
			# 如果更改 parent，更改前后的对象都需要重新生成children
			if (doc.parent)
				oldParent = db.organizations.findOne(doc.parent)
				db.organizations.direct.update(oldParent._id, {$set: {children: oldParent.calculateChildren()}});

		# 如果更改 parent 或 name, 需要更新 自己和孩子们的 fullname	
		if (modifier.$set.parent || modifier.$set.name)
			updateFields.fullname = obj.calculateFullname()
			children = db.organizations.find({parents: doc._id});
			children.forEach (child) ->
				db.organizations.direct.update(child._id, {$set: {fullname: child.calculateFullname()}})

		if !_.isEmpty(updateFields)
			db.organizations.direct.update(obj._id, {$set: updateFields})
		

	db.organizations.after.remove (userId, doc) ->
		if (doc.parent)
			parent = db.organizations.findOne(doc.parent)
			db.organizations.direct.update(parent._id, {$set: {children: parent.calculateChildren()}});



	Meteor.publish 'organizations', (spaceId)->
		
		unless this.userId
			return this.ready()
		
		user = db.users.findOne(this.userId);

		selector = {}
		if spaceId
			selector.space = spaceId
		else 
			selector.space = {$in: user.spaces()}

		console.log '[publish] organizations ' + spaceId

		return db.organizations.find(selector)