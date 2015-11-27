
var steedos_form = Steedos_data.getForm("af67fdsa8f78ds7f89s7fs6f7sfsdf");

var steedos_instance = Steedos_data.getInstance("bf67fdsa8f78ds7f89s7fs6f7sfsdf");

var fields = Steedos_data.steedosFieldToAutoField(steedos_form);

var formula_fields = Form_formula.getFormulaFieldVariable("Form_formula.field_values", steedos_form.fields);

var formId = 'instanceform';

Template.instanceform.helpers({
  formId: function (){
    return formId;
  },
  steedos_form: function (){
    return steedos_form;
  },
  innersubformContext:function (obj){
    obj["tableValues"] = steedos_instance.values[obj.code]
    obj["formId"] = formId;
    return obj;
  },
  instance: function (){
    return steedos_instance;
  },
  equals: function(a,b) {
    return Instanceform_Helpers.equals(a,b);
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

  'change .form-control': function(event){
    console.log("instanceform form-control change");
    //debugger;
    var code = event.target.name;
    Form_formula.run(code, "", formula_fields, AutoForm.getFormValues("instanceform").insertDoc, steedos_form.fields);
  
  },

  //子表删除行时，执行主表公式计算
  'click .remove-steedos-table-row': function(event, template){
    console.log("instanceform form-control change");
    var code = event.target.name;
    /*
      autoform-inputs 中 markChanged 函数中，对template 的更新延迟了100毫秒，
      此处为了能拿到删除列后最新的数据，此处等待markChanged执行完成后，再进行计算公式.
      此处给定等待101毫秒,只是为了将函数添加到 Timer线程中，并且排在markChanged函数之后。
    */
    setTimeout(function () {
      Form_formula.run(code, "", formula_fields, AutoForm.getFormValues("instanceform").insertDoc, steedos_form.fields);
    },101);

  }
});


