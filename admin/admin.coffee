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
			selector: db.spaces._selector

		SpaceUsers: 
			icon: "users"
			tableColumns: [
				{name: "space_name()"},
				{name: "name"},
				{name: "email"},
			]
			extraFields: ["space", "user"]
			newFormFields: "space,email"
			selector: db.space_users._selector

		Organizations: 
			icon: "sitemap"
			tableColumns: [
				{name: "space_name()"},
				{name: "fullname"},
			]
			extraFields: ["space", "name"]
			newFormFields: "space,name,parent,sort_no"
			selector: db.organizations._selector
					
		Apps: 
			icon: "star-o"
			tableColumns:  [
				{name: "name"},
				{name: "description"},
			]
	