@Users = db.users
@Spaces = db.spaces
@SpaceUsers = db.space_users
@Organizations = db.organizations
@Apps = db.apps


@AdminConfig = 
	name: "Steedos Admin"
	skin: "blue"
	userSchema: null,
	userSchema: db.users._simpleSchema,
	autoForm:
		omitFields: ['createdAt', 'updatedAt', 'created', 'created_by', 'modified', 'modified_by']
	collections: 

		Spaces: 
			icon: "globe"
			tableColumns: [
				{name: "name"},
				{name: "owner_name()"},
				{name: "is_paid"},
			]
			extraFields: ["owner"]
			newFormFields: "name"
			selector: (userId) ->
				if Meteor.isServer
					user = db.users.findOne({_id: userId})
					if user
						return {_id: {$in: user.spaces()}}
					else 
						return {}
				if Meteor.isClient
					if (Session.get("spaceId"))
						return {_id: Session.get("spaceId")}
					else 
						return {}

		SpaceUsers: 
			icon: "users"
			tableColumns: [
				{name: "space_name()"},
				{name: "name"},
				{name: "email"},
			]
			extraFields: ["space", "user"]
			newFormFields: "space,email"
			selector: (userId) ->
				if Meteor.isServer
					user = db.users.findOne({_id: userId})
					if user
						return {space: {$in: user.spaces()}}
					else 
						return {}
				if Meteor.isClient
					if (Session.get("spaceId"))
						return {_id: Session.get("spaceId")}
					else 
						return {}

		Organizations: 
			icon: "sitemap"
			tableColumns: [
				{name: "space_name()"},
				{name: "fullname"},
			]
			extraFields: ["space", "name"]
			newFormFields: "space,name,parent,sort_no"
			selector: (userId) ->
				if Meteor.isServer
					user = db.users.findOne({_id: userId})
					if user
						return {space: {$in: user.spaces()}}
					else 
						return {}
				if Meteor.isClient
					if (Session.get("spaceId"))
						return {_id: Session.get("spaceId")}
					else 
						return {}
					
		Apps: 
			icon: "star-o"
			tableColumns:  [
				{name: "name"},
				{name: "description"},
			]
	