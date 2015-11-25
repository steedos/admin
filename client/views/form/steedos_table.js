
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
  }

});

Template.steedos_table.events({
    'click .add-steedos-table-row': function (event, template) {
      debugger;

      var formcode = this.code;
      
      var tableobj = $("[name='"+formcode+"table']")[0];
      
      var formId = "instanceform";

      var rowObj = JSON.parse(tableobj.dataset.rowobj);

      for(var key in rowObj){
        $("[name='"+(formcode + ".$." + key)+"']").val(rowObj[key]);
      }

      var row_index = AutoForm.arrayTracker.info[formId][formcode].array.length;
      
      AutoForm.arrayTracker.addOneToField(formId, formcode, AutoForm.getFormSchema(formId),0,5000);
      
      tableobj.dataset.validrows = Steedos_table_Helpers.addValidrows(tableobj.dataset.validrows, row_index);

      console.log("row_index is " + row_index + "   " + JSON.stringify(rowObj));

      $("[name='"+formcode+".modal']")[0].dataset.rowindex = row_index;
      $("[name='"+formcode+".modal']")[0].dataset.rowobj = JSON.stringify(rowObj);
      $("#"+formcode+'-modal-header').html('新增');

      $("." + formcode + ".ui.modal")
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
                  var rowobj = JSON.parse(this.dataset.rowobj);

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
      debugger;
      console.debug("进入remove-steedos-table-row");
      event.preventDefault();
      var startTrack = new Date *1;

      var row_index = event.target.dataset.rowindex;

      var formcode = event.target.parentNode.parentNode.parentNode.parentNode.dataset.formcode;

      var formId = "instanceform";

      AutoForm.arrayTracker.removeFromFieldAtIndex(formId, formcode, row_index, AutoForm.getFormSchema(formId),0,5000);

      //隐藏删除行
      $("[name='"+row_index+"row']").css("display","none");

      var tableobj = $("[name='"+formcode+"table']")[0];
      tableobj.dataset.validrows = Steedos_table_Helpers.removeValidrows(tableobj.dataset.validrows, row_index);

      console.log(tableobj.dataset.validrows);
      
      //Steedos_table_Helpers.update_tableView(formcode,formId);

      console.debug("退出 remove-steedos-table-row");
      console.debug("消耗时间：" + (new Date() * 1 - startTrack) + "ms");

    },

    'click .edit-steedos-table-row': function (event, template) {
        var row_index = event.target.dataset.rowindex;

        var formcode = event.target.parentNode.parentNode.parentNode.parentNode.dataset.formcode;

        var tableobj = $("[name='"+formcode+"table']")[0];

        var rowObj = JSON.parse(tableobj.dataset.rowobj);

        var value_index = Steedos_table_Helpers.getValidrowIndex(tableobj.dataset.validrows, row_index);

        var rowValue = AutoForm.getFieldValue(formcode,"instanceform")[value_index];

        console.log("edit-steedos-table-row , rowValue is " + JSON.stringify(rowValue));

        for(var key in rowObj){
          $("[name='"+(formcode + ".$." + key)+"']").val(rowValue[key]);
        }

        $("[name='"+formcode+".modal']")[0].dataset.rowindex = row_index;
        $("[name='"+formcode+".modal']")[0].dataset.rowobj = JSON.stringify(rowObj);
        $("#"+formcode+'-modal-header').html('编辑');
        
        $("." + formcode + ".ui.modal")
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
                  var rowobj = JSON.parse(this.dataset.rowobj);

                  
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
                  //Steedos_table_Helpers.update_tableView(formcode,"instanceform");
                }
            })
            .modal('show')
        ;
    }
})