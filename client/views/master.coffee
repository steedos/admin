Template.masterLayout.helpers
	logged: ->
		if Meteor.userId()?
			$('html').addClass("noscroll").removeClass("scroll")
			return true
		else
			$('html').addClass("scroll").removeClass("noscroll")
			return false