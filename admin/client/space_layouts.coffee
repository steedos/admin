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
