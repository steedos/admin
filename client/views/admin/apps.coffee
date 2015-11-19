FlowRouter.route '/admin/apps/', 
  name: "adminApps",
  action: (params, queryParams) ->
      BlazeLayout.render 'masterLayout', {main: "adminApps"}
  


Template.adminApps.helpers

	selectedRow: ->
		if Session.get("selectedRow")
			return Session.get("selectedRow")
		return null

	formType: ->
		if Session.get("selectedRow")
			return "update"
		else
			return "insert"


Template.adminApps.onCreated ->


Template.adminApps.onRendered ->
	hooks =
		dataForm:
			onSuccess: (formType, result)->
				$('#dataFormPopup').modal("hide")
	AutoForm.hooks(hooks)



Template.adminApps.events
	"click #buttonAdd": (e, t) ->
		$('.dataTable').DataTable().rows().deselect();
		Session.set("selectedRow", null)
		$('#dataFormPopup').modal('show')
	
	"click #buttonEdit": (e, t) ->
		if !Session.get("selectedRow")
			return
		$('#dataFormPopup').modal('show')

	"click #buttonDelete": (e, t) ->
		if !Session.get("selectedRow")
			return
		Steedos.collections.Apps.remove({_id: Session.get("selectedRow")._id})

	'click tbody > tr': (event) ->
		dt = $('.dataTable').DataTable()
		selected = dt.rows( { selected: true } ).data()
		if selected.count()
			Session.set("selectedRow", selected[0])
		else
			Session.set("selectedRow", null);