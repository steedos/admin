Steedos.collections.Users = Meteor.users;

Steedos.collections.Users.permit(['insert', 'update', 'remove']).apply();


Steedos.collections.Users.attachSchema(new SimpleSchema({
  name: {
    type: String,
    label: "Name",
    max: 50
  },
  email: {
    type: String,
    label: "email",
    max: 200
  },
  locale: {
    type: String,
    label: "locale",
    max: 200
  },
  timezone: {
    type: String,
    label: "timezone",
    optional: true,
    max: 1000
  }
}));

Steedos.tables.Users = new Tabular.Table({
  name: "Users",
  collection: Steedos.collections.Users,
  lengthChange: false,
  buttons: [
      'copy', 'excel', 'pdf'
  ],
  select: {
    style: 'single'
  },
  columns: [
    {data: "name", title: "Name"},
    {data: "email", title: "Email"},
    {data: "locale", title: "Locale"}
  ]
});