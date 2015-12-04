Steedos.api.addCollection db.organizations, 
	excludedEndpoints: []
	routeOptions:
		authRequired: true
	endpoints:
		put:
			action: () ->

				collection = db.organizations
				try 
					entityIsUpdated = collection.update @urlParams.id, $set: @bodyParams

					if entityIsUpdated
						entity = collection.findOne @urlParams.id
						{status: "success", data: entity}
					else
						statusCode: 404
						body: {status: 'fail', message: 'Item not found'}
				catch e
					message = "Invalid request."
					if e.message	
						message = e.message
					else if e.sanitizedError
						if e.sanitizedError.message
							message = e.sanitizedError.message
					
					statusCode: 400
					body: status: 'error', message: message