
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

      var formcode = template.data.code;
      
      var tableobj = $("[name='"+formcode+"table']")[0];
      
      var formId = tableobj.dataset.formid;

      var rowObj = JSON.parse(tableobj.dataset.rowobj);

      for(var key in rowObj){
        $("[name='"+(formcode + ".$." + key)+"']").val(rowObj[key]);
      }

      var row_index = AutoForm.arrayTracker.info[formId][formcode].array.length;
      
      AutoForm.arrayTracker.addOneToField(formId, formcode, AutoForm.getFormSchema(formId),0,5000);
      
      tableobj.dataset.validrows = Steedos_table_Helpers.addValidrows(tableobj.dataset.validrows, row_index);

      console.log("row_index is " + row_index + "   " + JSON.stringify(rowObj));

      $("[name='"+formcode+".modal']")[0].dataset.rowindex = row_index;

      $("#"+formcode+'-modal-header').html('新增');

      $("." + formcode + ".ui.small.modal")
            .modal({
                inverted:true,
                closable:false,
                onDeny : function() {
                  alert('not yet');
                  return false;
                },
                onApprove: function() {
                  var row_index = this.dataset.rowindex;
                  var formcode = this.dataset.formcode;
                  var rowobj = JSON.parse($("[name='"+formcode+"table']")[0].dataset.rowobj);

                  var row_html = "<tr class='person-row' data-toggle='modal' name='" + row_index + "row'>"; 

                  row_html = row_html + "<td>" + row_index + "</td>";

                  for(var key in rowobj){
                    $("[name='"+(formcode + "."+row_index+"." + key)+"']").val($("[name='"+(formcode + ".$." + key)+"']").val());
                    row_html = row_html + "<td>" + $("[name='"+(formcode + ".$." + key)+"']").val() + "</td>";
                  }

                  row_html = row_html + 
                  "<td><span class='panel-controls'>"+ 
                      "<i class='remove icon remove-steedos-table-row' data-rowindex='" + row_index + "'></i>" +
                      "&nbsp;&nbsp;<i class='write icon edit-steedos-table-row' data-rowindex='" + row_index + "'></i>" +
                  "</span></td>" ;
                  row_html = row_html + "</tr>"

                  $("#"+formcode+'tbody').html($("#"+formcode+'tbody').html() + row_html);
                }
            })
            .modal('show')
        ;

    },

    'click .remove-steedos-table-row': function (event, template) {
      //debugger;
      console.debug("进入remove-steedos-table-row");
      
      var startTrack = new Date *1;

      var row_index = event.target.dataset.rowindex;

      var formcode = template.data.code;

      var tableobj = $("[name='"+formcode+"table']")[0];

      var formId = tableobj.dataset.formid;

      AutoForm.arrayTracker.removeFromFieldAtIndex(formId, formcode, row_index, AutoForm.getFormSchema(formId),0,5000);

      //隐藏删除行
      $("[name='"+row_index+"row']").css("display","none");
      
      tableobj.dataset.validrows = Steedos_table_Helpers.removeValidrows(tableobj.dataset.validrows, row_index);

      console.log(tableobj.dataset.validrows);

      console.debug("退出 remove-steedos-table-row");
      console.debug("消耗时间：" + (new Date() * 1 - startTrack) + "ms");

    },

    'click .edit-steedos-table-row': function (event, template) {
        var row_index = event.target.dataset.rowindex;

        var formcode = template.data.code;

        var tableobj = $("[name='"+formcode+"table']")[0];

        var formId = tableobj.dataset.formid;

        var rowObj = JSON.parse(tableobj.dataset.rowobj);

        var value_index = Steedos_table_Helpers.getValidrowIndex(tableobj.dataset.validrows, row_index);

        var rowValue = AutoForm.getFieldValue(formcode, formId)[value_index];

        console.log("edit-steedos-table-row , rowValue is " + JSON.stringify(rowValue));

        for(var key in rowObj){
          $("[name='"+(formcode + ".$." + key)+"']").val(rowValue[key]);
        }

        $("[name='"+formcode+".modal']")[0].dataset.rowindex = row_index;

        $("#"+formcode+'-modal-header').html('编辑');
        
        $("." + formcode + ".ui.small.modal")
            .modal({
                inverted:true,
                closable:false,
                onDeny : function() {
                  alert('not yet');
                  return false;
                },
                onApprove: function() {
                  var row_index = this.dataset.rowindex;
                  var formcode = this.dataset.formcode;
                  var rowobj = JSON.parse($("[name='"+formcode+"table']")[0].dataset.rowobj);

                  
                  var row_html = "<td>" + row_index + "</td>";

                  for(var key in rowobj){
                    $("[name='"+(formcode + "."+row_index+"." + key)+"']").val($("[name='"+(formcode + ".$." + key)+"']").val());
                    row_html = row_html + "<td>" + $("[name='"+(formcode + ".$." + key)+"']").val() + "</td>";
                  }

                  row_html = row_html + 
                  "<td><span class='panel-controls'>"+ 
                      "<i class='remove icon remove-steedos-table-row' data-rowindex='" + row_index + "'></i>" +
                      "&nbsp;&nbsp;<i class='write icon edit-steedos-table-row' data-rowindex='" + row_index + "'></i>" +
                  "</span></td>" ;
                  $("[name='"+row_index+"row']").html(row_html);
                }
            })
            .modal('show')
        ;
    },

    'change .form-control': function(event, template){

      console.log("steedos_table form-control change");

      var code = event.target.name;
      var formcode = template.data.code;

      var rowObj = JSON.parse($("[name='"+formcode+"table']")[0].dataset.rowobj);

      var rowIndx = $("[name='"+formcode+".modal']")[0].dataset.rowindex;

      var tableobj = $("[name='"+formcode+"table']")[0];

      var rowFormula = JSON.parse(tableobj.dataset.rowformula);

      var rowValue = {};

      $("[name='"+(formcode + "."+rowIndx+"." + code.split(".")[2])+"']").val($("[name='" + code + "']").val());

      for(var key in rowObj){

        rowValue[key] = $("[name='" + formcode + ".$." + key + "']").val();
      }

      console.log("rowValue is \n" + JSON.stringify(rowValue));

      Form_formula.run(code.split(".")[2], formcode + ".$.", rowFormula, rowValue, template.data.sfields);

    }
})