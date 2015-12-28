Router.route '/', ->
	if (Meteor.userId())
		Router.go("/admin");
	else 
		Router.go("/sign-in");



Router.route '/logout', ->
	AccountsTemplates.logout();


Router.route '/launchpad', ->
	this.render('launchpad');



Router.route '/account/profile', ->
	if Meteor.user()
		this.render('profile');