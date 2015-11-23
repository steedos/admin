Steedos_table_Helpers = {};
Template.registerHelper("Steedos_table_Helpers", Steedos_table_Helpers);

function arrayify(obj){
    result = [];
    for(var key in obj){
    result.push({code:key, value:obj[key]})
    }
    return result;
}


Template.registerHelper("arrayify", function(obj){
  return arrayify(obj);
});

Steedos_table_Helpers.equals = function (a, b) {
  return a === b;
};

Steedos_table_Helpers.update_tableView = function (code,formId){
    debugger;
    tbody_html = "";
    rowValues = AutoForm.getFieldValue(code,formId);
    for(var r = 0; r < rowValues.length; r++ ){
        tbody_html = tbody_html + "<tr>";
        columnValues = arrayify(rowValues[r]);
        
        //序
        tbody_html = tbody_html + "<td>" + r + "</td>";

        //字段值
        for(var c = 0 ; c < columnValues.length; c++){
            tbody_html = tbody_html + "<td>" + columnValues[c].value + "</td>";
        }

        //添加编辑按钮
        tbody_html = tbody_html + "<td><span class='panel-controls'><i class='write icon subform-row' data-rowindex='" + r + "'></i></span></td>"

        tbody_html = tbody_html + "</tr>";
    }
    $("#"+code+'tbody').html(tbody_html);
};