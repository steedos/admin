FlowRouter.route '/cloud/apps/', 
  name: "cloudApps",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "cloudApps"}
  

AutoForm.hooks
	appsForm:
		onSuccess: (formType, result)->
			$('#appsFormPopup').modal("hide")
		onError: (formType, error) ->
			toastr.error(error.message);

Template.cloudApps.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return db.apps.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.cloudApps.onCreated ->

Template.cloudApps.onRendered ->
	Session.set("selectedRowId", null);



Template.cloudApps.events
	"click #buttonAdd": (e, t) ->
		$('.dataTable').DataTable().rows().deselect();
		Session.set("selectedRowId", null)
		$('#appsFormPopup').modal('show')
	
	"click #buttonEdit": (e, t) ->
		if !Session.get("selectedRowId")
			return
		$('#appsFormPopup').modal('show')

	"click #buttonDelete": (e, t) ->
		if !Session.get("selectedRowId")
			return
		db.apps.remove {_id: Session.get("selectedRowId")}, (error) ->
			if error
				toastr.error(error.message);
			else
				toastr.info("Entry deleted.");

	'click tbody > tr': (event) ->
		dt = $('.dataTable').DataTable()
		selected = dt.rows( { selected: true } ).data()
		if selected.count()
			Session.set("selectedRowId", selected[0]._id)
		else
			Session.set("selectedRowId", null);