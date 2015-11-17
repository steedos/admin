Template.adminApps.helpers
	apps: ->
		Apps.find()

Template.adminApps.onCreated ->
	


Template.adminApps.events
	"click #tableAdd": (e, t) ->
		$('#appAdd')
		  .modal('show')
		;
