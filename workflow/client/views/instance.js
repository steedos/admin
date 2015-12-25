
var steedos_form = Steedos_data.getForm("af67fdsa8f78ds7f89s7fs6f7sfsdf");

var steedos_instance = Steedos_data.getInstance("bf67fdsa8f78ds7f89s7fs6f7sfsdf");

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
    return new SimpleSchema(Steedos_data_format.getAutoformSchema(steedos_form));
  },
  doc: function (){
    return steedos_instance.values;
  }
});


Template.instanceform.events({
  
  'click #submit': function(){

  },

  'change .form-control': function(event){
    console.log("instanceform form-control change");
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
      console.log(JSON.stringify(AutoForm.getFormValues("instanceform").insertDoc));
      Form_formula.run(code, "", formula_fields, AutoForm.getFormValues("instanceform").insertDoc, steedos_form.fields);
    },101);

  }
});


