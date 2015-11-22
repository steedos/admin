Steedos._BaseSchema = {
	created: {
		type: Date,
		autoValue: function(){		
			if (this.isInsert) 
				return new Date;
			else
				this.unset()
		}
	},
	created_by: {
		type: String,
		autoValue: function(){
			if (this.isInsert) 
				return Meteor.userId();
			else
				this.unset()
		},
	},
	modified: {
		type: Date,
		autoValue: function(){		
			if (this.isUpdate) 
				return new Date;
			else
				this.unset()
		},
	    denyInsert: true,
	    optional: true
	},
	modified_by: {
		type: String,
		autoValue: function(){
			if (this.isUpdate) 
				return Meteor.userId();
			else
				this.unset()
		},
	    optional: true
	},
}

// SimpleSchema.prototype.editableFields = function(){
// 	var self = this;
// 	fields = []
//     _.each(self._schema, function(def, field) {
//     	if (!def.autoValue)
//     		fields.push(field)
//     })
//     return fields
// }
