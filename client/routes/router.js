FlowRouter.route( '/logout', { 
        name: 'logout', 
        action: function(){
                AccountsTemplates.logout();
        }
})

FlowRouter.route('/', {
  name: "home",
  action: function(params, queryParams) {
  	if (Meteor.user())
	    BlazeLayout.render('masterLayout', {
	      footer: "footer",
	      main: "home",
	      nav: "nav",
	    });
  	else 
  		FlowRouter.go("/sign-in");
  }
});


FlowRouter.notFound = {
  action: function() {
    BlazeLayout.render('masterLayout', {
      footer: "footer",
      main: "pageNotFound",
      nav: "nav",
    });
  }
};


//Routes
AccountsTemplates.configureRoute('changePwd');
AccountsTemplates.configureRoute('forgotPwd');
AccountsTemplates.configureRoute('resetPwd');
AccountsTemplates.configureRoute('signIn');
AccountsTemplates.configureRoute('signUp');
AccountsTemplates.configureRoute('verifyEmail');
