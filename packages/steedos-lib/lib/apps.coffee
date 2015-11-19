Steedos.collections.Apps = new Meteor.Collection 'apps'

Steedos.collections.Apps.permit(['insert', 'update', 'remove']).apply();


Steedos.collections.Apps.attachSchema(new SimpleSchema({
  name: {
    type: String,
    label: "Name",
    max: 50
  },
  description: {
    type: String,
    label: "Description",
    max: 200
  },
  url: {
    type: String,
    label: "URL",
    max: 200
  },
  iconURL: {
    type: String,
    label: "Icon URL",
    optional: true,
    max: 1000
  }
}));

Steedos.tables.Apps = new Tabular.Table({
  name: "Apps",
  collection: Steedos.collections.Apps,
  lengthChange: false,
  buttons: [
      'copy', 'excel', 'pdf'
  ],
  select: {
    style: 'single'
  },
  columns: [
    {data: "name", title: "Name"},
    {data: "description", title: "Description"},
    {data: "url", title: "App URL"}
  ]
});