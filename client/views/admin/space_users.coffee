FlowRouter.route '/admin/space_users/', 
  name: "adminSpaceUsers",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "adminSpaceUsers"}
  

AutoForm.hooks
	spaceUsersForm:
		onSuccess: (formType, result)->
			$('#spaceUsersFormPopup').modal("hide")
		onError: (formType, error) ->
			toastr.error(error.message);

Template.adminSpaceUsers.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return Steedos.SpaceUsers.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.adminSpaceUsers.onCreated ->

Template.adminSpaceUsers.onRendered ->
	Session.set("selectedRowId", null);



Template.adminSpaceUsers.events
	"click #buttonAdd": (e, t) ->
		$('.dataTable').DataTable().rows().deselect();
		Session.set("selectedRowId", null)
		$('#spaceUsersFormPopup').modal('show')
	
	"click #buttonEdit": (e, t) ->
		if !Session.get("selectedRowId")
			return
		$('#spaceUsersFormPopup').modal('show')

	"click #buttonDelete": (e, t) ->
		if !Session.get("selectedRowId")
			return
		Steedos.SpaceUsers.remove {_id: Session.get("selectedRowId")}, (error) ->
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