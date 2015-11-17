var steedos_form = Steedos_data.getForm("af67fdsa8f78ds7f89s7fs6f7sfsdf");

var steedos_instance = Steedos_data.getInstance("bf67fdsa8f78ds7f89s7fs6f7sfsdf");

var fields = Steedos_data.steedosFieldToAutoField(steedos_form);

Template.steedos_table.helpers({
  
  subformValue: function(code){
    return Steedos_Helpers.get_subFormValue(code, fields, steedos_instance.values);
  },

  equals: function(a,b) {
    return Steedos_Helpers.equals(a,b);
  },

  append: function(a,b){
    return a + b ;
  },


});

Template.steedos_table.events({
    'click .subform-row': function (event) {
        debugger;
        $(".ui.modal")
            .modal({
                inverted:true
            })
            .modal('show')
        ;
    }
})