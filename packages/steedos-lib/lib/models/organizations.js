Steedos.Organizations = new Meteor.Collection('organizations')

Steedos.Organizations.permit(['insert', 'update', 'remove']).apply();

Steedos.Organizations._simpleSchema = new SimpleSchema({
	space: {
		type: String,
		optional: true,
	},
	name: {
		type: String,
		max: 200
	},
	parent: {
		type: String,
		optional: true,
	},
	users: {
		type: [String],
		optional: true,
	},
	is_company: {
		type: Boolean,
		optional: true,
	},
	parents: {
		type: [String],
		optional: true,
	},
	fullname: {
		type: String,
		optional: true,
	},
	children: {
		type: [String],
		optional: true,
	},
});
Steedos.Organizations.attachSchema(Steedos.Organizations._simpleSchema);

Steedos.Organizations._table = new Tabular.Table({
	name: "Organizations",
	collection: Steedos.Organizations,
	lengthChange: false,
	select: {
		style: 'single'
	},
	columns: [
		{data: "fullname"},
	],
	extraFields: ["name",'parent','space'],
	// Filter data by permission
	// selector: function() {
	// 	return {}
	// },
});

Steedos.collections.Organizations = Steedos.Organizations

if (Meteor.isServer) {

	Steedos.Organizations.getChildren = function(id){
		children = []
		childrenObjs = Steedos.Organizations.find({parent: id}, {}, {_id:1});
		childrenObjs.forEach(function(child) {
			children.push(child._id);
		})
		return children;
	};
	Steedos.Organizations.getRecursiveChildren = function(id){
		children = []
		childrenObjs = Steedos.Organizations.find({parents: id}, {}, {_id:1});
		childrenObjs.forEach(function(child) {
			children.push(child._id);
		})
		return children;
	};

	Steedos.Organizations.updateChildren = function(id) {
		children = Steedos.Organizations.getChildren(id);
		Steedos.Organizations.direct.update({
			_id: id
		}, {
			$set: {children: children}
		})
		return children;
	};

	Steedos.Organizations.getFullname = function(id){
		org = Steedos.Organizations.findOne({_id: id}, {}, {parent: 1, name: 1});

		fullname = org.name;

		if (!org.parent)
			return fullname;

		parentId = org.parent;
		while (parentId){
			parentOrg = Steedos.Organizations.findOne({_id: parentId}, {parent: 1, name: 1});
			fullname = parentOrg.name + "/" + fullname;
			parentId = parentOrg.parent
		}

		return fullname
	};

	Steedos.Organizations.updateFullname = function(id) {
		fullname = this.getFullname(id)
		Steedos.Organizations.direct.update({
			_id: id
		}, {
			$set: {fullname: fullname}
		})
	};

	Steedos.Organizations.getParents = function(parent){
		if (!parent)
			return []
		parents = [parent];

		parentId = parent;
		while (parentId){
			parentOrg = Steedos.Organizations.findOne({_id: parentId}, {parent: 1, name: 1});
			parentId = parentOrg.parent
			if (parentId){
				parents.push(parentId)
			}
		}

		return parents
	};

	Steedos.Organizations.before.insert(function(userId, doc){
		doc.created_by = userId;
		doc.created = new Date();

		doc.parents = Steedos.Organizations.getParents(doc.parent);
		doc.is_company = !doc.parent;
	});

	Steedos.Organizations.before.update(function(userId, doc, fieldNames, modifier, options){
		modifier.$set = modifier.$set || {};
		modifier.$set.modofied_by = userId;
		modifier.$set.modified = new Date();

		if (modifier.$set.parent){
			// parent 不能等于自己或者children
			if (doc._id == modifier.$set.parent)
				throw new Meteor.Error(400, "Invalid value parent for organization object.");

			// 更新parents
			modifier.$set.parents = Steedos.Organizations.getParents(modifier.$set.parent);
		} 

	});

	Steedos.Organizations.after.insert(function(userId, doc){
		if (doc.parent)
			Steedos.Organizations.updateChildren(doc.parent);
		Steedos.Organizations.updateFullname(doc._id);
	});

	Steedos.Organizations.after.update(function(userId, doc, fieldNames, modifier, options){
		// 如果更改 parent，更改前后的对象都需要重新生成children
		if (doc.parent){
			children = Steedos.Organizations.updateChildren(doc.parent);
		}
		if (modifier.$set.parent)
			children = Steedos.Organizations.updateChildren(modifier.$set.parent);

		// 如果更改 parent 或 name, 需要更新 自己和孩子们的 fullname	
		if (modifier.$set.parent || modifier.$set.name){
			Steedos.Organizations.updateFullname(doc._id);
			children = Steedos.Organizations.getRecursiveChildren(doc._id)
			_.each(children, function(childId){
				Steedos.Organizations.updateFullname(childId);
			})
		}

	})
}
