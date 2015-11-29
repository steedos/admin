Template.masterLayout.helpers
	logged: ->
		if Meteor.userId()?
			$('html').addClass("noscroll").removeClass("scroll")
			return true
		else
			$('html').addClass("scroll").removeClass("noscroll")
			return false

Template.masterLayout.onCreated ->
	self = this;

	self.minHeight = new ReactiveVar(
		$(window).height());

	$(window).resize ->
		self.minHeight.set($(window).height());

	$('body').addClass('fixed');


Template.masterLayout.onRendered ->
	self = this;
	self.minHeight.set($(window).height());
	if (self.view.isRendered) 
		MeteorAdminLTE.AdminLTE.options.sidebarSlimScroll=false
		MeteorAdminLTE.run()


Template.masterLayout.onDestroyed ->
	$('body').removeClass('fixed');


Template.masterLayout.helpers 
	minHeight: ->
		return Template.instance().minHeight.get() + 'px'
	