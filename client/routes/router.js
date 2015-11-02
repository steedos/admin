FlowRouter.route( '/logout', { 
        name: 'logout', 
        action: function(){
                AccountsTemplates.logout();
        }
})

FlowRouter.route('/', {
  name: "home",
  action: function(params, queryParams) {
  	if (Meteor.userId())
      FlowRouter.go("/launchpad/");
  	else 
  	 	FlowRouter.go("/sign-in");
  }
});

FlowRouter.route('/launchpad', {
  name: "launchpad",
  action: function(params, queryParams) {
      BlazeLayout.render('masterLayout', {
        main: "launchpad",
      });
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

FlowRouter.route('/account/linked', {
  name: "linked",
  action: function(params, queryParams) {
      BlazeLayout.render('masterLayout', {
        main: "linked",
      });
  }
});

FlowRouter.route('/app/chat', {
  name: "apps",
  action: function(params, queryParams) {
      BlazeLayout.render('masterLayout', {
        main: "app",
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
