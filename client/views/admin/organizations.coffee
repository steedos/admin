FlowRouter.route '/admin/organizations/', 
  name: "adminOrganizations",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "adminOrganizations"}
  


Template.adminOrganizations.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return Steedos.Organizations.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.adminOrganizations.onCreated ->
	hooks =
		organizationsForm:
			onSuccess: (formType, result)->
				$('#organizationsFormPopup').modal("hide")
			onError: (formType, error) ->
				toastr.error(error.message);

	AutoForm.hooks(hooks)

Template.adminOrganizations.onRendered ->
	Session.set("selectedRowId", null);



Template.adminOrganizations.events
	"click #buttonAdd": (e, t) ->
		$('.dataTable').DataTable().rows().deselect();
		Session.set("selectedRowId", null)
		$('#organizationsFormPopup').modal('show')
	
	"click #buttonEdit": (e, t) ->
		if !Session.get("selectedRowId")
			return
		$('#organizationsFormPopup').modal('show')

	"click #buttonDelete": (e, t) ->
		if !Session.get("selectedRowId")
			return
		Steedos.Organizations.remove({_id: Session.get("selectedRowId")})

	'click tbody > tr': (event) ->
		dt = $('.dataTable').DataTable()
		selected = dt.rows( { selected: true } ).data()
		if selected.count()
			Session.set("selectedRowId", selected[0]._id)
		else
			Session.set("selectedRowId", null);