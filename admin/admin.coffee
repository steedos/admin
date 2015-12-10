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

		spaces: db.spaces.adminCofig

		space_users: db.space_users.adminConfig

		organizations: db.organizations.adminConfig

	callbacks:
		onInsert: (name, insertDoc, updateDoc, currentDoc) ->
			if Meteor.isClient
				if name == "spaces"
					Meteor.call "setSpaceId", insertDoc._id, ->
						Session.set("spaceId", insertDoc._id)
	
