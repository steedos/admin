Meteor.startup ->
	Migrations.add
		version: 1
		up: ->
			db.users.find().forEach (user) ->
				modifier = 
					$set: {}

				if user.email? 
					if !user.emails || user.emails.length == 0
						console.log "Upgrade user email " + user._id
						modifier.$push = 
							emails: 
								address: user.email, 
								verified: !!user.primaryEmailVerified
						
				if user.emails && user.emails.length > 0
					if !user.steedos_id
						modifier.$set.steedos_id = user.emails[0].address
						if !user.name
							modifier.$set.name = user.emails[0].address.split('@')[0]
						if !user.username
							modifier.$set.username = user.emails[0].address.replace("@","_").replace(".","_")
					else
						if !user.name
							modifier.$set.name = user.steedos_id.split('@')[0]
						if !user.username
							modifier.$set.username = user.steedos_id.replace("@","_").replace(".","_")

				if user.is_cloud_admin
					Roles.addUsersToRoles user._id, "admin", Roles.GLOBAL_GROUP
					
				Meteor.users.update	{_id: user._id}, modifier