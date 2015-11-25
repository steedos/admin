FlowRouter.route '/space/:spaceId', 
	name: "switchSpace",
	action: (params, queryParams) ->
		Session.set "spaceId", params.spaceId
