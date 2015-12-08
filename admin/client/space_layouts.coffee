Template.SpaceAdminLayout.onCreated ->
	self = this;

	self.minHeight = new ReactiveVar($(window).height());

	$(window).resize ->
	self.minHeight.set($(window).height());

	$('body').addClass('fixed');



Template.SpaceAdminLayout.onRendered ->
	this.minHeight.set($(window).height());


Template.SpaceAdminLayout.onDestroyed ->
	$('body').removeClass('fixed');


Template.SpaceAdminLayout.helpers 
	minHeight: ->
		return Template.instance().minHeight.get() + 'px'

	isSpaceAdmin: ->
		return Roles.userIsInRole(Meteor.userId(), "admin", Session.get("spaceId"))

Template.SpaceAdminLayout.events
	'click .btn-delete': (e,t) ->
		_id = $(e.target).attr('doc')
		if Session.equals 'admin_collection_name', 'Users' 
			Session.set 'admin_id', _id
			Session.set 'admin_doc', Meteor.users.findOne(_id)
		else
			Session.set 'admin_id', parseID(_id)
			Session.set 'admin_doc', adminCollectionObject(Session.get('admin_collection_name')).findOne(parseID(_id))