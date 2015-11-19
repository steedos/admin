Template.adminApps.helpers
	apps: ->
		Apps.find()

	selectedRow: ->
		if Session.get("selectedRowId")
			return Apps.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.adminApps.onRendered ->
	hooks =
		appForm:
			onSuccess: (formType, result)->
				$('#appFormPopup').modal("hide")
	AutoForm.hooks(hooks)



Template.adminApps.events
	"click #buttonAdd": (e, t) ->
		$('.dataTable').DataTable().rows().deselect();
		Session.set("selectedRowId", null)
		$('#appFormPopup').modal('show')
	
	"click #buttonEdit": (e, t) ->
		if !Session.get("selectedRowId")
			return
		$('#appFormPopup').modal('show')

	"click #buttonDelete": (e, t) ->
		if !Session.get("selectedRowId")
			return
		Apps.remove({_id: Session.get("selectedRowId")})

	'click tbody > tr': (event) ->
		dt = $('.dataTable').DataTable()
		selected = dt.rows( { selected: true } ).data()
		if selected.count()
			Session.set("selectedRowId", selected[0]._id)
		else
			Session.set("selectedRowId", null);