FlowRouter.route( '/logout', { 
        name: 'logout', 
        action: function(params, queryParams){
                AccountsTemplates.logout();
        }
})

FlowRouter.route('/', {
  name: "home",
  action: function(params, queryParams) {
  	if (Meteor.userId())
      FlowRouter.go("/launchpad", params, queryParams);
  	else 
  	 	FlowRouter.go("/sign-in", params, queryParams);
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

FlowRouter.route('/apps/:app_name', {
  name: "appFrame",
  action: function(params, queryParams) {
      BlazeLayout.render('masterLayout', {
        main: "appFrame",
      });
  }
});

FlowRouter.route('/flow/form', {
  name: "instanceform",
  action: function(params, queryParams) {
      BlazeLayout.render('masterLayout', {
        main: "instanceform",
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
