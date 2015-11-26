@Spaces = db.spaces
@SpaceUsers = db.space_users
@Organizations = db.organizations
@Apps = db.apps

@AdminConfig = 
	name: "Steedos Admin"
	skin: "green"
	collections: 

		Spaces: 
			tableColumns: [
				{name: "name"},
				{name: "owner_name()"},
				{name: "is_paid"},
			]
		SpaceUsers: 
			tableColumns: [
				{name: "name"},
				{name: "email"},
			]
		Organizations: 
			tableColumns: [
				{name: "fullname"},
			]
		Apps: 
			tableColumns:  [
				{name: "name", label: "name"},
				{name: "description", label: "Description"},
			]
		
	

