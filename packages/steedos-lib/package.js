Package.describe({
	name: 'steedos:lib',
	version: '0.0.1',
	summary: 'Steedos libraries',
	git: ''
});

Package.onUse(function(api) { 
	api.versionsFrom('1.0');

	api.use('reactive-var');
	api.use('reactive-dict');
	api.use('coffeescript');
	api.use('random');
	api.use('ddp');
	api.use('check');
	api.use('ddp-rate-limiter');
	api.use('underscore');
	api.use('tracker');
	api.use('session');
	
	api.use('nimble:restivus');
	api.use('aldeed:simple-schema');
	api.use('aldeed:collection2');
	api.use('aldeed:tabular');
	api.use('aldeed:autoform');
	api.use('aldeed:autoform-select2');
	api.use('ongoworks:security');
	api.use('matb33:collection-hooks');


	api.use(['webapp'], 'server');

	api.use('momentjs:moment', 'client');
	api.use('mrt:moment-timezone', 'client');

	// TAPi18n
	api.use('templating', 'client');

	api.use('tap:i18n', ['client', 'server']);
	//api.add_files("package-tap.i18n", ["client", "server"]);
	tapi18nFiles = ['i18n/en.i18n.json', 'i18n/zh-CN.i18n.json']
	api.addFiles(tapi18nFiles, ['client', 'server']);
	
	// COMMON
	api.addFiles('lib/collection_helpers.js');
	api.addFiles('lib/core.coffee');
	api.addFiles('lib/tapi18n.coffee');

	api.addFiles('lib/models/users.coffee');
	api.addFiles('lib/models/spaces.coffee');
	api.addFiles('lib/models/space_users.coffee');
	api.addFiles('lib/models/organizations.coffee');


	// EXPORT
	api.export('Steedos');
});

Package.onTest(function(api) {

});
