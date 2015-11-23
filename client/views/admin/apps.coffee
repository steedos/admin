FlowRouter.route '/admin/apps/', 
  name: "adminApps",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "adminApps"}
  

AutoForm.hooks
	appsForm:
		onSuccess: (formType, result)->
			$('#appsFormPopup').modal("hide")
		onError: (formType, error) ->
			toastr.error(error.message);

Template.adminApps.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return Steedos.Apps.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.adminApps.onCreated ->

Template.adminApps.onRendered ->
	Session.set("selectedRowId", null);



Template.adminApps.events
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
		Steedos.Apps.remove {_id: Session.get("selectedRowId")}, (error) ->
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