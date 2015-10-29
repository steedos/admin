Template.nav.helpers({
        
        "user": function(){

                return Meteor.user();

        },

        displayName: function(){

                if (Meteor.user())
                        if (Meteor.user().name)
                                return Meteor.user().name
                        else if (Meteor.user().email)
                                return Meteor.user().email
                        else
                                return Meteor.user()._id
                else
                        return "Nobody"
        },

        avatar: function(){
                if (Meteor.user())
                        if (Meteor.user().profile)
                                return Meteor.user().profile.avatar
        }
})

Template.nav.onRendered(function(){
    
        $('.ui.menu .ui.dropdown').dropdown({
                on: 'hover'
        });

        $('.ui.menu a.item')
                .on('click', function() {
                        $(this)
                            .addClass('active')
                            .siblings()
                            .removeClass('active');
                });

})