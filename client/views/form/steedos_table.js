
Template.steedos_table.helpers({

  equals: function(a,b) {
    return Steedos_table_Helpers.equals(a,b);
  },

  append: function(a,b) {
    return a + b ;
  }

});

Template.steedos_table.events({
    'click .subform-row': function (event) {
        debugger;

        var row_index = event.target.dataset.rowindex;

        var formcode = event.target.parentNode.parentNode.parentNode.parentNode.dataset.formcode;

        for(var key in this){
          $("[name='"+(formcode + ".$." + key)+"']").val(this[key]);
        }

        $("[name='"+formcode+".modal']")[0].dataset.rowindex = row_index;
        $("[name='"+formcode+".modal']")[0].dataset.rowobj = JSON.stringify(this);

        $("." + formcode + ".ui.modal")
            .modal({
                inverted:true,
                closable:false,
                onDeny : function() {
                  alert('not yet');
                  return false;
                },
                onApprove: function() {
                  debugger;

                  var row_index = this.dataset.rowindex;
                  var formcode = this.dataset.formcode;
                  var rowobj = JSON.parse(this.dataset.rowobj);

                  for(var key in rowobj){
                    $("[name='"+(formcode + "."+row_index+"." + key)+"']").val($("[name='"+(formcode + ".$." + key)+"']").val());
                  }

                  Steedos_table_Helpers.update_tableView(formcode,"instanceform");
                }
            })
            .modal('show')
        ;
    }
})