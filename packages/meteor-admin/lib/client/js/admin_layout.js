Template.AdminLayout.onCreated(function () {
  var self = this;

  self.minHeight = new ReactiveVar(
    $(window).height());

  $(window).resize(function () {
    self.minHeight.set($(window).height());
  });

  $('body').addClass('fixed');
});

Template.AdminLayout.onRendered(function () {
  this.minHeight.set($(window).height());
});

Template.AdminLayout.onDestroyed(function () {
  $('body').removeClass('fixed');
});

Template.AdminLayout.helpers({
  minHeight: function () {
    return Template.instance().minHeight.get() + 'px'
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
