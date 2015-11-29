Template.AdminLayout.onRendered(function () {
  if (this.view.isRendered) {
    MeteorAdminLTE.AdminLTE.options.sidebarSlimScroll=false
    MeteorAdminLTE.run()
  }
});


dataTableOptions = {
    "aaSorting": [],
    "bPaginate": true,
    "bLengthChange": false,
    "bFilter": true,
    "bSort": true,
    "bInfo": true,
    "bAutoWidth": false
};
