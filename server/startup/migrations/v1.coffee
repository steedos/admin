Meteor.startup ->
	Migrations.add
		version: 1
		up: ->
			Steedos.models.Users.find().forEach (user) ->
				if user.email? 
					if !user.emails || user.emails.length == 0
						console.log "Upgrade user email " + user._id
						Meteor.users.update(
					      {_id: user._id},
					      {$push: {emails: {address: user.email, verified: !!user.primaryEmailVerified}}}
					    );


