FlowRouter.route '/cloud/spaces/', 
  name: "cloudSpaces",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "cloudSpaces"}
  

AutoForm.hooks
	spacesForm:
		onSuccess: (formType, result)->
			$('#spacesFormPopup').modal("hide")
		onError: (formType, error) ->
			toastr.error(error.message);

Template.cloudSpaces.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return db.spaces.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.cloudSpaces.onCreated ->

Template.cloudSpaces.onRendered ->
	Session.set("selectedRowId", null);



Template.cloudSpaces.events
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
		db.spaces.remove {_id: Session.get("selectedRowId")}, (error) ->
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