
var steedos_form = Steedos_data.getForm("af67fdsa8f78ds7f89s7fs6f7sfsdf");

var steedos_instance = Steedos_data.getInstance("bf67fdsa8f78ds7f89s7fs6f7sfsdf");

var fields = Steedos_data.steedosFieldToAutoField(steedos_form);

var formula_fields = Form_formula.getFormulaFieldVariable("Form_formula.formula_values", steedos_form.fields);

console.log(formula_fields);

Template.instanceform.helpers({
  
  steedos_form: function (){
    return steedos_form;
  },
  instance: function (){
    return steedos_instance;
  },
  equals: function(a,b) {
    return Steedos_Helpers.equals(a,b);
  },
  fields: function (){
    return new SimpleSchema(fields);
  },
  doc: function (){
    return steedos_instance.values;
  }
});

Template.instanceform.events({
  // 'click button': function () {
  //   // increment the counter when button is clicked
  //   Session.set('counter', Session.get('counter') + 1);
  // }
  'click #submit': function(){

  },

  'click #au-sb-ok': function(){
    Steedos_Helpers.update_subFormView("出差费用明细", fields, AutoForm.getFormValues("instanceform").insertDoc);
  },

  'change .form-control': function(event){

    console.log("change............");
    //debugger;
    var code = event.target.name;
    
    Form_formula.run(code, formula_fields, AutoForm.getFormValues("instanceform").insertDoc, steedos_form.fields);
  
  }
});


