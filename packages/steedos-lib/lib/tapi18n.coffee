@t = (key, replaces...) ->
	if _.isObject replaces[0]
		return TAPi18n.__ key, replaces
	else
		return TAPi18n.__ key, { postProcess: 'sprintf', sprintf: replaces }

@tr = (key, options, replaces...) ->
	if _.isObject replaces[0]
		return TAPi18n.__ key, options, replaces
	else
		return TAPi18n.__ key, options, { postProcess: 'sprintf', sprintf: replaces }

@isRtl = (language) ->
	# https://en.wikipedia.org/wiki/Right-to-left#cite_note-2
	return language?.split('-').shift().toLowerCase() in ['ar', 'dv', 'fa', 'he', 'ku', 'ps', 'sd', 'ug', 'ur', 'yi']

if Meteor.isClient
	TAPi18n.setLanguage "zh-CN"

SimpleSchema.prototype.i18n = (tableName) ->
	if (Meteor.isServer) 
		return;

	self = this;
	_.each(self._schema, (value, key) ->
		if (!value) 
			return
		self._schema[key].label = (key) ->
			return t(tableName + "_" + key)
	)