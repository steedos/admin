
Template.steedos_table.helpers({

  equals: function(a,b) {
    return Steedos_table_Helpers.equals(a,b);
  },

  append: function(a,b) {
    return a + b ;
  },

  initValidrows: function(arr){
    return Steedos_table_Helpers.initValidrows(arr);
  },

  initRowobj: function(sfield){

    var rowObj = {};
    for(var i = 0 ; i < sfield.length ; i++){
      rowObj[sfield[i].code] = '';
    }
    return JSON.stringify(rowObj);
  },

  initRowFormula: function(sfield){
    var formulas = Form_formula.getFormulaFieldVariable("Form_formula.field_values", sfield);
    console.log("steedos_table formulas is \n" + JSON.stringify(formulas));
    return JSON.stringify(formulas);
  }

});

Template.steedos_table.events({
    'click .add-steedos-table-row': function (event, template) {

      var tableCode = template.data.code;
      
      var steedosTable = Steedos_table_Helpers.getTable(tableCode);

      var formId = steedosTable.formid;

      var rowObj = JSON.parse(steedosTable.rowobj);

      //获取新增行的index;
      var row_index = AutoForm.arrayTracker.info[formId][tableCode].array.length;

      for(var key in rowObj){
        Steedos_table_Helpers.updateTableModalFieldValue(tableCode + ".$." + key, rowObj[key]);
      }
      
      AutoForm.arrayTracker.addOneToField(formId, tableCode, AutoForm.getFormSchema(formId),0,5000);

      Steedos_table_Helpers.updateTable(tableCode, {"validrows" : Steedos_table_Helpers.addValidrows(steedosTable.validrows, row_index)});

      Steedos_table_Helpers.updateTableModal(tableCode, {"rowindex" : row_index, "method" : event.target.dataset.method});

      Steedos_table_Helpers.showTableModal(tableCode , event.target.dataset.title);
    },

    'click .remove-steedos-table-row': function (event, template) {

      var tableCode = template.data.code;

      var steedosTable = Steedos_table_Helpers.getTable(tableCode);

      var row_index = event.target.dataset.rowindex;

      var formId = steedosTable.formid;

      AutoForm.arrayTracker.removeFromFieldAtIndex(formId, tableCode, row_index, AutoForm.getFormSchema(formId),0,5000);

      //隐藏删除行
      $("[name='"+row_index+"row']").css("display","none");
      
      //steedosTable.dataset.validrows = Steedos_table_Helpers.removeValidrows(steedosTable.dataset.validrows, row_index);

      Steedos_table_Helpers.updateTable(tableCode, {"validrows" : Steedos_table_Helpers.removeValidrows(steedosTable.validrows, row_index)});
    },

    'click .edit-steedos-table-row': function (event, template) {

        var row_index = event.target.dataset.rowindex;

        var tableCode = template.data.code;

        var steedosTable = Steedos_table_Helpers.getTable(tableCode);

        var formId = steedosTable.formid;

        var rowObj = JSON.parse(steedosTable.rowobj);

        var value_index = Steedos_table_Helpers.getValidrowIndex(steedosTable.validrows, row_index);

        var rowValue = AutoForm.getFieldValue(tableCode, formId)[value_index];

        console.log("edit-steedos-table-row , rowValue is " + JSON.stringify(rowValue));

        for(var key in rowObj){
          Steedos_table_Helpers.updateTableModalFieldValue(tableCode + ".$." + key, rowValue[key]);
        }

        Steedos_table_Helpers.updateTableModal(tableCode, {"rowindex" : row_index, "method" : event.target.dataset.method});

        Steedos_table_Helpers.showTableModal(tableCode , event.target.dataset.title);
    },

    'change .form-control': function(event, template){

      console.log("steedos_table form-control change");

      var fieldCode = event.target.name;

      var tableCode = template.data.code;

      var steedosTable = Steedos_table_Helpers.getTable(tableCode);

      var steedosTableModal = Steedos_table_Helpers.getTableModal(tableCode);

      var rowObj = JSON.parse(steedosTable.rowobj);

      var rowIndx = steedosTableModal.rowindex;

      var rowFormula = JSON.parse(steedosTable.rowformula);

      var rowValue = {};

      if (rowIndx < 0) 
        return ;

      Steedos_table_Helpers.update_autoFormArrayItem(rowIndx, tableCode, rowObj);
      
      for(var key in rowObj){
        rowValue[key] = Steedos_table_Helpers.getTableModalValue(tableCode + ".$." + key);
      }

      console.log("fieldCode is " + fieldCode + "; rowValue is \n" + JSON.stringify(rowValue));

      Form_formula.run(fieldCode.split(".")[2], tableCode + ".$.", rowFormula, rowValue, template.data.sfields);

    },

    'click #steedos-table-ok-button': function(event, template){
      
      var tableCode = template.data.code;

      var steedosTable = Steedos_table_Helpers.getTable(tableCode);

      var steedosTableModal = Steedos_table_Helpers.getTableModal(tableCode);

      var row_index = steedosTableModal.rowindex;
      
      var rowobj = JSON.parse(steedosTable.rowobj);

      var call_method = steedosTableModal.method;

      if(call_method == "add"){
        Steedos_table_Helpers.add_row(row_index, tableCode, rowobj);
      }

      if(call_method == "edit"){
        Steedos_table_Helpers.update_row(row_index, tableCode, rowobj);
      }
    }
})