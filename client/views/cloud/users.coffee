FlowRouter.route '/cloud/users/', 
  name: "cloudUsers",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "cloudUsers"}
  

AutoForm.hooks
	usersForm:
		onSuccess: (formType, result)->
			$('#usersFormPopup').modal("hide")
		onError: (formType, error) ->
			toastr.error(error.message);

Template.cloudUsers.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return db.users.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.cloudUsers.onCreated ->

Template.cloudUsers.onRendered ->
	Session.set("selectedRowId", null);



Template.cloudUsers.events
	"click #buttonAdd": (e, t) ->
		$('.dataTable').DataTable().rows().deselect();
		Session.set("selectedRowId", null)
		$('#usersFormPopup').modal('show')
	
	"click #buttonEdit": (e, t) ->
		if !Session.get("selectedRowId")
			return
		$('#usersFormPopup').modal('show')

	"click #buttonDelete": (e, t) ->
		if !Session.get("selectedRowId")
			return
		db.users.remove {_id: Session.get("selectedRowId")}, (error) ->
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