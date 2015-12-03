Meteor.startup ->
	FS.HTTP.setBaseUrl("/api")

	db.avatars = new FS.Collection "avatars",  
	  stores: [new FS.Store.FileSystem("avatars")]

	db.avatars.allow
		insert: ->
			return true;
		update: ->
			return true;
		remove: ->
			return true;
		download: ->
			return true;
