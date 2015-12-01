@Users = Steedos.users
@spaces = Steedos.spaces
@space_users = Steedos.space_users
@organizations = Steedos.organizations


@AdminConfig = 
	name: "Steedos Admin"
	skin: "blue"
	userSchema: null,
	userSchema: Steedos.users._simpleSchema,
	autoForm:
		omitFields: ['createdAt', 'updatedAt', 'created', 'created_by', 'modified', 'modified_by']
	collections: 

		spaces: 
			icon: "globe"
			tableColumns: [
				{name: "name"},
				{name: "owner_name()"},
				{name: "is_paid"},
			]
			extraFields: ["owner"]
			newFormFields: "name"
			selector: Steedos.spaces._selector

		space_users: 
			icon: "users"
			tableColumns: [
				{name: "space_name()"},
				{name: "name"},
				{name: "email"},
			]
			extraFields: ["space", "user"]
			newFormFields: "space,email"
			selector: Steedos.space_users._selector

		organizations: 
			icon: "sitemap"
			tableColumns: [
				{name: "space_name()"},
				{name: "fullname"},
			]
			extraFields: ["space", "name"]
			newFormFields: "space,name,parent"
			selector: Steedos.organizations._selector

	