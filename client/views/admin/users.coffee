FlowRouter.route '/admin/users/', 
  name: "adminUsers",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "adminUsers"}
  


Template.adminUsers.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return Steedos.Users.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.adminUsers.onCreated ->
	hooks =
		usersForm:
			onSuccess: (formType, result)->
				$('#usersFormPopup').modal("hide")
			onError: (formType, error) ->
				toastr.error(error.message);
	AutoForm.hooks(hooks)

Template.adminUsers.onRendered ->
	Session.set("selectedRowId", null);



Template.adminUsers.events
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
		Steedos.Users.remove({_id: Session.get("selectedRowId")})

	'click tbody > tr': (event) ->
		dt = $('.dataTable').DataTable()
		selected = dt.rows( { selected: true } ).data()
		if selected.count()
			Session.set("selectedRowId", selected[0]._id)
		else
			Session.set("selectedRowId", null);