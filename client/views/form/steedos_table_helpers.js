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

var get_table = function (tableCode){
    return $("[name='"+tableCode+"table']")[0];
};

Steedos_table_Helpers.getTable = function (tableCode){
    console.log("steedos_table dataset is " + JSON.stringify(get_table(tableCode).dataset));
    return get_table(tableCode).dataset;
};

Steedos_table_Helpers.updateTable = function(tableCode, values){

    var table = get_table(tableCode);

    for(var key in values){
        table.dataset[key] = values[key];
    }

    return table;
};

var get_table_modal = function (tableCode){
    return $("[name='"+tableCode+".modal']")[0];
};

Steedos_table_Helpers.updateTableModalFieldValue = function(fieldCode , value){
    $("[name='" + fieldCode + "']").val(value);
};

Steedos_table_Helpers.getTableModal = function (tableCode){
    console.log("steedos_table modal dataset is " + JSON.stringify(get_table(tableCode).dataset));
    return get_table_modal(tableCode).dataset;
};

Steedos_table_Helpers.getTableModalValue = function (fieldCode){
    return $("[name='" + fieldCode + "']").val();
}

Steedos_table_Helpers.updateTableModal = function (tableCode, values){

    var table_modal = get_table_modal(tableCode);

    for(var key in values){
        table_modal.dataset[key] = values[key];
    }

    return table_modal;
};

Steedos_table_Helpers.showTableModal = function (tableCode, modalTitle){
    
    $("#"+tableCode+'-modal-header').html(modalTitle);

    $("#" + tableCode + "modal").modal('show');
};

Steedos_table_Helpers.initValidrows = function (arr){
    var validrows = new Array();
    for(var i = 0 ; i < arr.length ; i++){
      validrows.push(i + "");
    }
    return validrows.toString();
};

Steedos_table_Helpers.removeValidrows = function (validrows_str, row_index){
    var validrows = new Array();
    if (validrows_str !="")
        validrows = validrows_str.split(",");
    var id = validrows.indexOf(row_index);
    if (id > -1)
        validrows.splice(id,1);
    return validrows.toString();
};

Steedos_table_Helpers.addValidrows = function (validrows_str, row_index){
    var validrows = new Array();
    if (validrows_str !="")
        validrows = validrows_str.split(",");
    validrows.push(row_index);
    return validrows.toString();
};

Steedos_table_Helpers.getValidrowIndex = function (validrows_str, row_index){
    var validrows = new Array();
    if (validrows_str !="")
        validrows = validrows_str.split(",");
    return validrows.indexOf(row_index);
};

Steedos_table_Helpers.update_row = function (row_index, tableCode, rowobj){
    $("[name='"+row_index+"row']").html(get_tds_html(row_index, tableCode, rowobj));
};

var get_tds_html = function(row_index, tableCode, rowobj){
    var tds_html = "<td>" + row_index + "</td>";

    for(var key in rowobj){
        tds_html = tds_html + "<td>" + $("[name='"+(tableCode + ".$." + key)+"']").val() + "</td>";
    }

    tds_html = tds_html + 
                    "<td>" + 
                        "<span class='panel-controls'>" + 
                            "<span class='glyphicon glyphicon-remove remove-steedos-table-row' data-rowindex='" + row_index + "' ></span>" +
                            "&nbsp;" + 
                            "<span class='glyphicon glyphicon-pencil edit-steedos-table-row' data-rowindex='" + row_index + "' data-title='修改' data-method='edit'></span>" +
                        "</span>" + 
                    "</td>";

    return tds_html;
};

var get_tr_html = function(row_index, tableCode, rowobj){

    var tr_html = "<tr class='person-row' data-toggle='modal' name='" + row_index + "row'>"; 

    tr_html = tr_html + get_tds_html(row_index, tableCode, rowobj);

    tr_html = tr_html + "</tr>";

    return tr_html;
};

Steedos_table_Helpers.update_autoFormArrayItem = function(row_index, tableCode, rowobj){
    for(var key in rowobj){
        $("[name='"+(tableCode + "."+row_index+"." + key)+"']").val($("[name='"+(tableCode + ".$." + key)+"']").val());
    }
};

Steedos_table_Helpers.add_row = function (row_index, tableCode, rowobj){

    Steedos_table_Helpers.update_autoFormArrayItem(row_index, rowobj);

    var rows_html = $("#"+tableCode+'tbody').html() + get_tr_html(row_index, tableCode, rowobj);
    
    $("#"+tableCode+'tbody').html(rows_html);
};
