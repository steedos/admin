db.apps = new Meteor.Collection('apps')

db.apps.permit(['insert', 'update', 'remove']).apply();

db.apps.attachSchema new SimpleSchema 
	name:  
		type: String,
		max: 50
	description: 
		type: String,
		max: 200
	url: 
		type: String,
		max: 200
	iconURL: 
		type: String,
		optional: true,
		max: 1000

