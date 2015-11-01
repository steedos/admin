Meteor.startup ->
	Migrations.add
		version: 1
		up: ->
			Steedos.models.Users.find().forEach (user) ->
				if user.email? 
					if !user.emails || user.emails.length = 0
						Meteor.users.update(
					      {_id: this.userId},
					      {$push: {emails: {address: user.email, verified: user.primaryEmailVerified}}}
					    );
