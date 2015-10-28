FlowRouter.route( '/logout', { 
        name: 'logout', 
        action: function(){
                AccountsTemplates.logout();
        }
})