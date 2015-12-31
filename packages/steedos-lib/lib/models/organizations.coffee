db.organizations = new Meteor.Collection('organizations')


db.organizations._simpleSchema = new SimpleSchema
	space: 
		type: String,
		optional: true,
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
			type: "select2",
			afFieldInput: 
				multiple: true
			options: ->
				options = []
				selector = {}
				if Session.get("spaceId")
					selector = {space: Session.get("spaceId")}

				objs = db.space_users.find(selector, {name:1, sort: {name:1}})
				objs.forEach (obj) ->
					options.push
						label: obj.name,
						value: obj.user
				return options
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

db.organizations.adminConfig =
	icon: "sitemap"
	label: ->
		return t("db.organizations")
	tableColumns: [
		{name: "fullname"},
		{name: "users_count()"},
		{name: "space_name()"},
	]
	extraFields: ["space", "name", "users"]
	newFormFields: "space,name,parent,users"
	editFormFields: "name,parent,users"
	selector: (userId, connection) ->
		if Meteor.isServer
			spaceId = connection["spaceId"]
			console.log "[selector] filter space_users " + spaceId
			if spaceId
				return {space: spaceId}
			else
				return {space: "-1"}

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
		childrenObjs = db.organizations.find({parent: this._id}, {fields: {_id:1}});
		childrenObjs.forEach (child) ->
			children.push(child._id);
		return children;

	calculateUsers: ->
		users = []
		spaceUsers = db.space_users.find({organization: this._id}, {fields: {user:1}});
		spaceUsers.forEach (user) ->
			users.push(user.user);
		return users;

	space_name: ->
		space = db.spaces.findOne({_id: this.space});
		return space?.name

	users_count: ->
		if this.users
			return this.users.length
		else 
			return 0
		

if (Meteor.isServer) 

	db.organizations.before.insert (userId, doc) ->
		doc.created_by = userId;
		doc.created = new Date();
		#doc.is_company = !doc.parent;
		if (!doc.space)
			throw new Meteor.Error(400, t("organizations_error.space_required"));
		# check space exists
		space = db.spaces.findOne(doc.space)
		if !space
			throw new Meteor.Error(400, t("organizations_error.space_not_found"));
		# only space admin can update space_users
		if space.admins.indexOf(userId) < 0
			throw new Meteor.Error(400, t("organizations_error.space_admins_only"));
		if doc.users
			doc.users.forEach (User) ->
				oldUser = db.space_users.findOne({user: User,space: doc.space})
				if oldUser.organization
					db.organizations.direct.update({_id: oldUser.organization},{$pull: {users: User}})
		# 同一个space中不能有同名的organization，parent 不能有同名的 child
		if doc.parent
			parentOrg = db.organizations.findOne(doc.parent)
			if parentOrg.children
				nameOrg = db.organizations.find({_id: {$in: parentOrg.children}, name: doc.name}).count()
				if nameOrg>0
					throw new Meteor.Error(400, t("organizations_error.organizations_name_exists")) 
		else			
			existed = db.organizations.find({name: doc.name, space: doc.space,fullname:doc.name}).count()				
			if existed>0
				throw new Meteor.Error(400, t("organizations_error.organizations_name_exists"))



	db.organizations.after.insert (userId, doc) ->
		updateFields = {}
		obj = db.organizations.findOne(doc._id)
		
		updateFields.parents = obj.calculateParents();
		updateFields.fullname = obj.calculateFullname()

		if !_.isEmpty(updateFields)
			db.organizations.direct.update(obj._id, {$set: updateFields})

		if doc.parent
			parent = db.organizations.findOne(doc.parent)
			db.organizations.direct.update(parent._id, {$set: {children: parent.calculateChildren()}});

		if doc.users
			_.each doc.users, (userId) ->
				db.space_users.direct.update({user: userId,space: doc.space}, {$set: {organization: doc._id}})


	db.organizations.before.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		# check space exists
		space = db.spaces.findOne(doc.space)
		if !space
			throw new Meteor.Error(400, t("organizations_error.space_not_found"));
		# only space admin can update space_users
		if space.admins.indexOf(userId) < 0
			throw new Meteor.Error(400, t("organizations_error.space_admins_only"));

		if (modifier.$set.space)
			throw new Meteor.Error(400, t("organizations_error.space_readonly"));

		if (modifier.$set.parents)
			throw new Meteor.Error(400, t("organizations_error.parents_readonly"));

		if (modifier.$set.children)
			throw new Meteor.Error(400, t("organizations_error.children_readonly"));

		if (modifier.$set.fullname)
			throw new Meteor.Error(400, t("organizations_error.fullname_readonly"));

		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		if (!modifier.$set.users && doc.users)
			db.space_users.update({user: {$in: doc.users},space: doc.space},{$set: {organization: ""}},{multi: true})	

		if modifier.$set.users
			removeUsers = []
			addUsers = []
			if !doc.users
				addUsers.push user for user in modifier.$set.users
			else
				removeUsers.push user for user in doc.users when 0 > modifier.$set.users.indexOf(user)				
				addUsers.push user for user in modifier.$set.users when 0 > doc.users.indexOf(user)			
			# 编辑users时，所添加或删除的space_users之前所属的organization字段要更新
			db.space_users.update({user: {$in: removeUsers},space: doc.space},{$set: {organization: ""}},{multi: true})						
			addUsers.forEach (User) ->
				oldUser = db.space_users.findOne({user: User,space: doc.space})
				if oldUser.organization
					db.organizations.direct.update({_id: oldUser.organization},{$pull: {users: User}})						

		if (modifier.$set.parent)
			# parent 不能等于自己或者 children
			parentOrg = db.organizations.findOne({_id: modifier.$set.parent})
			if (doc._id == parentOrg._id || parentOrg.parents.indexOf(doc._id)>=0)
				throw new Meteor.Error(400, t("organizations_error.parent_is_self"))
		   	# 同一个 parent 不能有同名的 child
			if parentOrg.children
				nameOrg = db.organizations.find({_id: {$in: parentOrg.children}, name: modifier.$set.name}).count()
				if (nameOrg > 0 ) && (modifier.$set.name != doc.name)
					throw new Meteor.Error(400, t("organizations_error.organizations_name_exists"))
		else if (modifier.$set.name != doc.name)					
			existed = db.organizations.find({name: modifier.$set.name, space: doc.space,fullname:modifier.$set.name}).count()				
			if existed > 0
				throw new Meteor.Error(400, t("organizations_error.organizations_name_exists"))
		

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
		
		if modifier.$set.users
			_.each modifier.$set.users, (userId) ->
				db.space_users.direct.update({user: userId,space:doc.space},{$set: {organization: doc._id}})

	
	db.organizations.before.remove (userId, doc) ->
		# check space exists
		space = db.spaces.findOne(doc.space)
		if !space
			throw new Meteor.Error(400, t("organizations_error.space_not_found"));
		# only space admin can remove space_users
		if space.admins.indexOf(userId) < 0
			throw new Meteor.Error(400, t("organizations_error.space_admins_only"));

		# can not delete organization with children
		if (doc.children && doc.children.length>0)
			throw new Meteor.Error(400, t("organizations_error.organization_has_children"));

	db.organizations.after.remove (userId, doc) ->
		if (doc.parent)
			parent = db.organizations.findOne(doc.parent)
			db.organizations.direct.update(parent._id, {$set: {children: parent.calculateChildren()}});

		if doc.users
			_.each doc.users, (userId) ->
				db.space_users.direct.update({user: userId}, {$unset: {organization: 1}})

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