Meteor.startup(function() {
    // Add Facebook configuration entry
    ServiceConfiguration.configurations.update(
      { "service": "facebook" },
      {
        $set: {
          "appId": "XXXXXXXXXXXXXXX",
          "secret": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        }
      },
      { upsert: true }
    );

    // Add GitHub configuration entry
    ServiceConfiguration.configurations.update(
      { "service": "google" },
      {
        $set: {
          "clientId": "XXXXXXXXXXXXXXXXXXXX",
          "secret": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        }
      },
      { upsert: true }
    );
});