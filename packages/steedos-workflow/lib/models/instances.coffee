db.instances = new Meteor.Collection('instances')

if Meteor.isServer

	Meteor.publish 'instanceWithFormFlow', (instanceId)->
		
		unless this.userId
			return this.ready()
		
		unless instanceId
			return this.ready()

		console.log '[publish] instance and flow forms' + spaceId

		instance = db.instances.find({_id: instanceId})

		return [
			db.instances.find({_id: instanceId}),
			db.flows.find({_id: instance.flow}),
			db.forms.find({_id: instance.form})
		]