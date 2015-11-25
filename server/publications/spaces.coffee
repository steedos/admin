Meteor.publish 'spaces', ->
	unless this.userId
		return this.ready()

	console.log '[publish] user spaces'

	self = this;

	handle = db.space_users.find({user: this.userId}).observe 
		added: (doc) ->
			if doc.space
				console.log "[publish] user space added " + doc.space
				space = db.spaces.findOne doc.space
				if space
					self.added "spaces", doc.space, space;
		changed: (newDoc, oldDoc) ->
			console.log "[publish] user space changed " + newDoc.space
			newSpace = db.spaces.findOne newDoc.space
			if newSpace
				self.added "spaces", newDoc.space, newSpace;
			if oldDoc.space
				self.removed "spaces", oldDoc.space;
		removed: (oldDoc) ->
			if oldDoc.space
				console.log "[publish] user space removed " + oldDoc.space
				self.removed "spaces", oldDoc.space;
		
	
	self.ready();

	self.onStop ->
		handle.stop();
