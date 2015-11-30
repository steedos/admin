db.apps = new Meteor.Collection('apps')

db.apps.permit(['insert', 'update', 'remove']).apply();

db.apps.attachSchema new SimpleSchema 
	type: 
		type: String,
		allowedValues: [
			"system",
			"space",
			"user"
		],
		autoform: 
			options: [{
				label: "System",
				value: "system"
			},
			{
				label: "Space",
				value: "space"
			},
			{
				label: "User",
				value: "user"
			}]
	space:
		type: String,
		optional: true,
		autoform: 
			type: "hidden",
			defaultValue: ->
				return Session.get("spaceId");
	name:  
		type: String,
	description: 
		type: String,
		optional: true,
	appURL: 
		type: String,
	icon: 
		type: String,
	iconImage: 
		type: String,
		optional: true,
	badge: 
		type: Number,
		optional: true,
		autoform:
			omit: true
	internal: 
		type: Boolean,
		optional: true,
		autoform:
			omit: true

db.apps.defaultApps = [
	{ _id: "workflow", type: "system", name: "Workflow", icon: "check-square-o", iconImage: "/images/apps/workflow/AppIcon76x76.png", appURL: "https://www.steedos.com/applications/workflow/" },
	{ _id: "chat", type: "system", name: "Chat", icon: "comments-o", iconImage: "/images/apps/chat/AppIcon76x76.png", appURL: "https://chat.steedos.com/" },
	{ _id: "drive", type: "system", name: "Drive", icon: "files-o", iconImage: "/images/apps/drive/AppIcon76x76.png", appURL: "https://drive.steedos.com/"},
	{ _id: "mail", type: "system", name: "Mail", icon: "at", iconImage: "/images/apps/mail/AppIcon76x76.png", appURL: "https://mail.steedos.com/"},
	{ _id: "admin", type: "system", name: "Settings", icon: "gears", appURL: "/admin", internal: true, badge: 1},
]

if Meteor.isServer
	Meteor.startup ->
		if db.apps.find().count() == 0
			_.each db.apps.defaultApps, (app)->
				db.apps.insert(app);

	db.apps.before.insert (userId, doc) ->
		doc.created_by = userId;
		doc.created = new Date();

		if !Roles.userIsInRole(userId, ['admin'])
			if (!doc.type == "system")
				throw new Meteor.Error(400, t("apps_error.cloud_admin_is_required"));