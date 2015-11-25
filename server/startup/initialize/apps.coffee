Meteor.startup ->
	if db.apps.find().count() == 0
		data = [
			{ name: "workflow", description: "Workflow", url: "https://www.steedos.com/applications/workflow/" },
			{ name: "chat", description: "Chat", url: "https://chat.steedos.com/" },
			{ name: "drive", description: "Drive", url: "https://drive.steedos.com/"},
			{ name: "mail", description: "Mail", url: "https://mail.steedos.com/"},
		]
		_.each data, (app)->
			db.apps.insert(app);