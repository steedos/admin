Template.appFrame.helpers
	appURL: ->
		app_name = this.app_name

		app = Apps.findOne({name: app_name});
		if app
			return app.url

		return "about:blank"