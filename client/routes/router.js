FlowRouter.route( '/logout', { 
        name: 'logout', 
        action: function(){
                AccountsTemplates.logout();
        }
})

FlowRouter.route('/', {
  name: "home",
  action: function(params, queryParams) {
  	//if (Meteor.user())
	    BlazeLayout.render('masterLayout', {
	      footer: "footer",
	      main: "home",
	      nav: "nav",
	    });
  	//else 
  	// 	FlowRouter.go("/sign-in");
  }
});


FlowRouter.route('/account/profile', {
  name: "profile",
  action: function(params, queryParams) {
      BlazeLayout.render('masterLayout', {
        main: "profile",
      });
  }
});


FlowRouter.route('/account/password', {
  name: "password",
  action: function(params, queryParams) {
      BlazeLayout.render('masterLayout', {
        main: "password",
      });
  }
});

FlowRouter.notFound = {
  action: function() {
    BlazeLayout.render('loginLayout', {
      main: "pageNotFound",
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
