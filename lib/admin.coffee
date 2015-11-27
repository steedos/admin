@Users = db.users
@Spaces = db.spaces
@SpaceUsers = db.space_users
@Organizations = db.organizations
@Apps = db.apps


@AdminConfig = 
	name: "Steedos Admin"
	skin: "green"
	userSchema: null,
	userSchema: db.users._simpleSchema,
	autoForm:
		omitFields: ['createdAt', 'updatedAt', 'created', 'created_by', 'modified', 'modified_by']
	collections: 

		Spaces: 
			tableColumns: [
				{name: "name"},
				{name: "owner_name()"},
				{name: "is_paid"},
			]
			extraFields: ["owner"]
			changeSelector: (selector, userId) ->
				if (!selector)
					selector = {}
				user = db.users.findOne({_id: userId})
				if user
					selector = {$and: [{_id: {$in: user.spaces()}}, selector]};

		SpaceUsers: 
			tableColumns: [
				{name: "space_name()"},
				{name: "name"},
				{name: "email"},
			]
			extraFields: ["space", "user"]
			selectorX: (userId) ->
				selector = {user: userId}

		Organizations: 
			tableColumns: [
				{name: "space_name()"},
				{name: "fullname"},
			]
			extraFields: ["space", "name"]
			changeSelector: (selector, userId) ->
				if (!selector)
					selector = {}
				user = db.users.findOne({_id: userId})
				if user
					selector = {$and: [{space: {$in: user.spaces()}}, selector]};
					
		Apps: 
			tableColumns:  [
				{name: "name"},
				{name: "description"},
			]
	