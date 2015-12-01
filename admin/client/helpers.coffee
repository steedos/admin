UI.registerHelper 'admin_fields', ->
	collection = AdminConfig.collections[Session.get 'admin_collection_name']
	if UI.currentView.lookup("admin_current_doc")()
		return collection.editFormFields
	else
		return collection.newFormFields
