Meteor.startup ->
	Mongo.ObjectID.prototype.toString = ->
		return this._str