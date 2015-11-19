
Template.steedos_table.helpers({

  equals: function(a,b) {
    return Steedos_Helpers.equals(a,b);
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

        $("[name='"+formcode+".modal']")[0].dataset.row_index = row_index;
        $("[name='"+formcode+".modal']")[0].dataset.rowobj = JSON.stringify(this);

        $("." + formcode + ".ui.modal")
            .modal({
                inverted:true,
                closable:false,
                row_index:row_index,
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

                  alert('ok');
                }
            })
            .modal('show')
        ;
    },
    'click #au-sb-ok': function(event){
      debugger;
      Steedos_Helpers.update_subFormView("出差费用明细", fields, AutoForm.getFormValues("instanceform").insertDoc);
    },
})