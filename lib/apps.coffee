@Apps = new Meteor.Collection 'apps'

Meteor.isClient && Meteor.subscribe "apps"

@Apps.attachSchema(new SimpleSchema({
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


@TabularTables = {}

Meteor.isClient && Template.registerHelper('TabularTables', TabularTables);

@TabularTables.Apps = new Tabular.Table({
  name: "Apps",
  collection: Apps,
  columns: [
    {data: "name", title: "Name"},
    {data: "description", title: "Description"},
    {data: "url", title: "App URL"}
  ]
});