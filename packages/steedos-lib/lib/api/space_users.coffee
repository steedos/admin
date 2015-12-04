Steedos.api.addCollection db.space_users, 
	excludedEndpoints: []
	routeOptions:
		authRequired: true
	endpoints:
		put:
			action: () ->
				collection = db.space_users
				try 
					entityIsUpdated = collection.update @urlParams.id, $set: @bodyParams

					if entityIsUpdated
						entity = collection.findOne @urlParams.id
						{status: "success", data: entity}
					else
						statusCode: 404
						body: {status: 'fail', message: 'Item not found'}
				catch e
					if e.reason
						statusCode: 400
						body: status: 'error', message: e.reason
					else
						statusCode: 500
						body: status: 'error', message: e