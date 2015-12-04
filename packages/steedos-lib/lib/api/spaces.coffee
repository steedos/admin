Steedos.api.addCollection db.spaces, 
	excludedEndpoints: ["getAll"]
	routeOptions:
		authRequired: true
	endpoints:
		put:
			action: () ->
				collection = db.spaces
				entityIsUpdated = collection.update @urlParams.id, 
					$set: 
						@bodyParams
				if entityIsUpdated
					entity = collection.findOne @urlParams.id
					{status: "success", data: entity}
				else
					statusCode: 404
					body: {status: 'fail', message: 'User not found'}