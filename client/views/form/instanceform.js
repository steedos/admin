
var steedos_form = Steedos_data.getForm("af67fdsa8f78ds7f89s7fs6f7sfsdf");

var steedos_instance = Steedos_data.getInstance("bf67fdsa8f78ds7f89s7fs6f7sfsdf");

var fields = Steedos_data.steedosFieldToAutoField(steedos_form);

var formula_fields = Form_formula.getFormulaFieldVariable("formula_values", steedos_form.fields);

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
  subformValue: function(code){
    return Steedos_Helpers.get_subFormValue(code, fields, steedos_instance.values);
  },
  fields: function (){
    return new SimpleSchema(fields);
  },
  doc: function (){
    return steedos_instance.values;
  }
});

AutoForm.addHooks("instanceform", {
  onError: function () {
    console.log("onError hook called with arguments", arguments);
    console.log("onError hook context:", this);
  },
  onSuccess: function () {
    console.log("onSuccess hook called with arguments", arguments);
    console.log("onSuccess hook context:", this);
  },
  before: {
    demoSubmission: function (doc) {
      console.log("before method hook called with arguments", arguments);
      console.log("before method hook context:", this);
      return doc;
    }
  },
  after: {
    demoSubmission: function () {
      console.log("after method hook called with arguments", arguments);
      console.log("after method hook context:", this);
    }
  },
  formToDoc: function (doc) {
    console.log("formToDoc hook called with arguments", arguments);
    console.log("formToDoc hook context:", this);
    return doc;
  },
  docToForm: function (doc) {
    console.log("docToForm hook called with arguments", arguments);
    console.log("docToForm hook context:", this);
    return doc;
  },
  beginSubmit: function () {
    console.log("beginSubmit hook called with arguments", arguments);
    console.log("beginSubmit hook context:", this);
  },
  endSubmit: function () {
    console.log("endSubmit hook called with arguments", arguments);
    console.log("endSubmit hook context:", this);
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
    
    var code = event.target.name;
    
    Form_formula.run(code, formula_fields, AutoForm.getFormValues("instanceform").insertDoc);
  
  }
});


