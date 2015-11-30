Router.route '/', ->
	if (Meteor.userId())
		Router.go("/launchpad");
	else 
		Router.go("/sign-in");



Router.route '/logout', ->
	AccountsTemplates.logout();


Router.route '/launchpad', ->
	this.render('launchpad');


Router.route '/apps/:app_id', ->
	app = db.apps.findOne({_id: this.params.app_id})
	if app
		if app.internal
			Router.go(app.appURL)
		this.render 'appFrame', 
			data: 
				appURL: app.appURL
				

Router.route '/account/profile', ->
	this.render('profile');


Router.route '/account/password', ->
	this.render('password');

Router.route '/account/linked', ->
	this.render('linked');



Router.route '/flow/form', ->
	this.render('instanceform');