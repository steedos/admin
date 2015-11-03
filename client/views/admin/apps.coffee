Template.adminApps.helpers
	apps: ->
		Apps.find()

Template.adminApps.onCreated ->
	
	@TabularTables = {}

	Template.registerHelper('TabularTables', @TabularTables);

	@TabularTables.Apps = new Tabular.Table({
	  name: "Apps",
	  collection: Apps,
	  columns: [
	    {data: "name", title: "Name"},
	    {data: "description", title: "Description"},
	    {data: "url", title: "App URL"}
	  ]
	});


Template.adminApps.events
	"click .app-info": (e, t) ->
