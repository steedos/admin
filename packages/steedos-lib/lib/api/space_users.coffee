Steedos.api.addCollection db.space_users, 
	excludedEndpoints: []
	routeOptions:
		authRequired: true
	endpoints:
		put:
			action: () ->
				collection = db.space_users
				error = null
				
				entityIsUpdated = collection.update @urlParams.id, $set: @bodyParams, (e) ->
					error = e

				if entityIsUpdated
					entity = collection.findOne @urlParams.id
					{status: "success", data: entity}
				else if error
					statusCode: 500
					body: status: 'fail', message: error.reason
				else
					statusCode: 404
					body: {status: 'fail', message: 'Item not found'}
