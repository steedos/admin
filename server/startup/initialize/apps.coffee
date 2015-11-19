Meteor.startup ->
	if Steedos.collections.Apps.find().count() == 0
		data = [
			{ name: "workflow", description: "Workflow", url: "https://www.steedos.com/applications/workflow/" },
			{ name: "chat", description: "Chat", url: "https://chat.steedos.com/" },
			{ name: "drive", description: "Drive", url: "https://drive.steedos.com/"},
			{ name: "mail", description: "Mail", url: "https://mail.steedos.com/"},
		]
		_.each data, (app)->
			Steedos.collections.Apps.insert(app);