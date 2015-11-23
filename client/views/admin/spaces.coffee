FlowRouter.route '/admin/spaces/', 
  name: "adminSpaces",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "adminSpaces"}
  

AutoForm.hooks
	spacesForm:
		onSuccess: (formType, result)->
			$('#spacesFormPopup').modal("hide")
		onError: (formType, error) ->
			toastr.error(error.message);

Template.adminSpaces.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return Steedos.Spaces.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.adminSpaces.onCreated ->

Template.adminSpaces.onRendered ->
	Session.set("selectedRowId", null);



Template.adminSpaces.events
	"click #buttonAdd": (e, t) ->
		$('.dataTable').DataTable().rows().deselect();
		Session.set("selectedRowId", null)
		$('#spacesFormPopup').modal('show')
	
	"click #buttonEdit": (e, t) ->
		if !Session.get("selectedRowId")
			return
		$('#spacesFormPopup').modal('show')

	"click #buttonDelete": (e, t) ->
		if !Session.get("selectedRowId")
			return
		Steedos.Spaces.remove({_id: Session.get("selectedRowId")})

	'click tbody > tr': (event) ->
		dt = $('.dataTable').DataTable()
		selected = dt.rows( { selected: true } ).data()
		if selected.count()
			Session.set("selectedRowId", selected[0]._id)
		else
			Session.set("selectedRowId", null);