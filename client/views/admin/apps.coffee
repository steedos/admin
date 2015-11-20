FlowRouter.route '/admin/apps/', 
  name: "adminApps",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "adminApps"}
  


Template.adminApps.helpers

	selectedRow: ->
		if Session.get("selectedRowId")
			return Steedos.collections.Apps.findOne({_id: Session.get("selectedRowId")})
		return null

	formType: ->
		if Session.get("selectedRowId")
			return "update"
		else
			return "insert"


Template.adminApps.onCreated ->
	hooks =
		dataForm:
			onSuccess: (formType, result)->
				$('#dataFormPopup').modal("hide")
	AutoForm.hooks(hooks)

Template.adminApps.onRendered ->
	Session.set("selectedRowId", null);



Template.adminApps.events
	"click #buttonAdd": (e, t) ->
		$('.dataTable').DataTable().rows().deselect();
		Session.set("selectedRowId", null)
		$('#dataFormPopup').modal('show')
	
	"click #buttonEdit": (e, t) ->
		if !Session.get("selectedRowId")
			return
		$('#dataFormPopup').modal('show')

	"click #buttonDelete": (e, t) ->
		if !Session.get("selectedRowId")
			return
		Steedos.collections.Apps.remove({_id: Session.get("selectedRowId")})

	'click tbody > tr': (event) ->
		dt = $('.dataTable').DataTable()
		selected = dt.rows( { selected: true } ).data()
		if selected.count()
			Session.set("selectedRowId", selected[0]._id)
		else
			Session.set("selectedRowId", null);