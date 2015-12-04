Steedos.api.addCollection db.space_users, 
	excludedEndpoints: []
	routeOptions:
		authRequired: true
	endpoints:
		put:
			action: () ->
				collection = db.space_users
				entityIsUpdated = collection.update @urlParams.id, 
					$set: 
						@bodyParams
				if entityIsUpdated
					entity = collection.findOne @urlParams.id
					{status: "success", data: entity}
				else
					statusCode: 404
					body: {status: 'fail', message: 'User not found'}