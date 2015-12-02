db.spaces = new Meteor.Collection('spaces')

db.spaces.permit(['insert', 'update', 'remove']).apply();

db.spaces.attachSchema new SimpleSchema
	name: 
		type: String,
		unique: true,
		max: 200
	owner: 
		type: String,
		optional: true,
		autoform:
			type: "select2",
			options: ->
				options = []
				selector = {}
				if Session.get("spaceId")
					selector = {space: Session.get("spaceId")}

				objs = db.space_users.find(selector, {name:1, sort: {name:1}})
				objs.forEach (obj) ->
					options.push
						label: obj.name,
						value: obj.user
				return options

			defaultValue: ->
				return Meteor.userId

	admins: 
		type: [String],
		optional: true,
		autoform: 
			type: "select2",
			afFieldInput: 
				multiple: true
			options: ->
				options = []
				selector = {}
				if Session.get("spaceId")
					selector = {space: Session.get("spaceId")}

				objs = db.space_users.find(selector, {name:1, sort: {name:1}})
				objs.forEach (obj) ->
					options.push
						label: obj.name,
						value: obj.user
				return options

	balance: 
		type: Number,
		optional: true,
	is_paid: 
		type: Boolean,
		label: t("Spaces_isPaid"),
		optional: true,
		autoform:
			readonly: true
		# 余额>0为已付费用户
		autoValue: ->
			balance = this.field("balance")
			if (balance.isSet)
				return balance.value>0
			else
				this.unset()


if Meteor.isClient
	db.spaces.simpleSchema().i18n("db.spaces")

db.spaces._selector = (userId) ->
	if Meteor.isServer
		spaceId = Session.get("spaceId")
		if spaceId
			return {space: spaceId}
		else
			return {}
	if Meteor.isClient
		return {}


db.spaces.helpers

	owner_name: ->
		owner = db.users.findOne({_id: this.owner});
		return owner && owner.name;
	
	admins_name: ->
		if (!this.admins)
			return ""
		admins = db.users.find({_id: {$in: this.admins}}, {fields: {name:1}});
		adminNames = []
		admins.forEach (admin) ->
			adminNames.push(admin.name)
		return adminNames.toString();

	add_user: (userId, user_accepted) ->
		spaceUserObj = db.space_users.findOne({user: userId, space: this._id})
		userObj = db.users.findOne(userId);
		if (!userObj)
			return;
		if (spaceUserObj)
			db.space_users.direct.update spaceUserObj._id, 
				name: userObj.name,
				email: userObj.email,
				space: this._id,
				user: userObj._id,
				user_accepted: user_accepted
		else 
			db.space_users.insert
				name: userObj.name,
				email: userObj.email,
				space: this._id,
				user: userObj._id,
				user_accepted: user_accepted
		

if Meteor.isClient

	spaceWatch = db.spaces.find({})
	spaceWatch.observeChanges
		removed: (_id)->
			if Session.get("spaceId") == _id
				Session.set("spaceId", null)

if Meteor.isServer

	db.spaces.before.insert (userId, doc) ->
		doc.created_by = userId
		doc.created = new Date()
		
		doc.owner = userId
		doc.admins = [userId]


	db.spaces.after.insert (userId, doc) ->
		if (doc.admins)
			space = db.spaces.findOne(doc._id)
			_.each doc.admins, (admin) ->
				space.add_user(admin, true)
			

	db.spaces.before.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};
		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();

		# 自动添加 Owner 为管理员
		if (modifier.$set.owner)
			if (!modifier.$set.admins)
				modifier.$set.admins = [modifier.$set.owner]
			if (modifier.$set.admins.indexOf(modifier.$set.owner) <0)
				modifier.$set.admins.push(modifier.$set.owner)

	db.spaces.before.remove (userId, doc) ->
		db.space_users.direct.remove({space: doc._id});

	db.spaces.after.update (userId, doc, fieldNames, modifier, options) ->
		# Update space users record to trigger publish spaces record changes to client.
		space_user = db.space_users.findOne({space: doc._id})
		db.space_users.direct.update(space_user._id, {$set: {modified: new Date()}})





	# publish users spaces
	# we only publish spaces current user joined.
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
					self.changed "spaces", newDoc.space, newSpace;
				# if oldDoc.space != newDoc.space
				# 	console.log "[publish] user space removed " + newDoc.space
				# 	self.removed "spaces", oldDoc.space;
			removed: (oldDoc) ->
				if oldDoc.space
					console.log "[publish] user space removed " + oldDoc.space
					self.removed "spaces", oldDoc.space;
			
		
		self.ready();

		self.onStop ->
			handle.stop();


	Meteor.methods
		setSpaceId: (spaceId) ->
			Session.set "spaceId", spaceId
			return Session.get "spaceId"
		getSpaceId: ()->
			return Session.get "spaceId"

	
