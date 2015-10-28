// Package metadata for Meteor.js web platform (https://www.meteor.com/)
// This file is defined within the Meteor documentation at
//
//   http://docs.meteor.com/#/full/packagejs
//
// and it is needed to define a Meteor package
'use strict';

Package.describe({
  name: 'steedos:useraccounts-flow-routing',
  summary: 'UserAccounts package providing routes configuration capability via kadira:flow-router.',
  version: '1.12.4',
  git: 'https://github.com/meteor-useraccounts/flow-routing.git'
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1.0.3');

  api.use([
    'check',
    'kadira:blaze-layout',
    'kadira:flow-router',
    'underscore',
    'steedos:useraccounts-core'
  ], ['client', 'server']);

  api.imply([
    'kadira:blaze-layout@2.1.0',
    'kadira:flow-router@2.7.0',
    'steedos:useraccounts-core'
  ], ['client', 'server']);

  api.addFiles([
    'lib/core.js',
  ], ['client', 'server']);

  api.addFiles([
    'lib/client/client.js',
    'lib/client/templates_helpers/at_input.js'
  ], ['client']);
});
