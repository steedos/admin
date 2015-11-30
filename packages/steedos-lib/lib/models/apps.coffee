db.apps = new Meteor.Collection('apps')

db.apps.permit(['insert', 'update', 'remove']).apply();

db.apps.attachSchema new SimpleSchema 
	name:  
		type: String,
	description: 
		type: String,
	appURL: 
		type: String,
	icon: 
		type: String,
		optional: true,
	iconImage: 
		type: String,
		optional: true,
	isSystem: 
		type: Boolean,
		optional: true,

db.apps.defaultApps = [
	{ name: "workflow", description: "Workflow", icon: "check-square-o", iconImage: "/images/apps/workflow/AppIcon76x76.png", appURL: "https://www.steedos.com/applications/workflow/" },
	{ name: "chat", description: "Chat", icon: "comments-o", iconImage: "/images/apps/chat/AppIcon76x76.png", appURL: "https://chat.steedos.com/" },
	{ name: "drive", description: "Drive", icon: "files-o", iconImage: "/images/apps/drive/AppIcon76x76.png", appURL: "https://drive.steedos.com/"},
	{ name: "mail", description: "Mail", icon: "at", iconImage: "/images/apps/mail/AppIcon76x76.png", appURL: "https://mail.steedos.com/"},
	{ name: "admin", description: "Settings", icon: "gears", appURL: "/admin", isSystem: true},
] 

if Meteor.isServer
	Meteor.startup ->
		if db.apps.find().count() == 0
			_.each db.apps.defaultApps, (app)->
				db.apps.insert(app);