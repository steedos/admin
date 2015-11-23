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

Mongo.Collection.prototype.i18n = () ->
	if (Meteor.isServer) 
		return;

	self = this;

	if (!self._c2)
		return;

	if (!self._c2._simpleSchema)
		return;

	_schema = self._c2._simpleSchema._schema;

	_.each(_schema, (value, key) ->
		if (!value) 
			return
		self._c2._simpleSchema._schema[key].label = t(self._name + "_" + key)
	)

if Meteor.isClient
	Tracker.autorun ->
		lang = Session.get("TAPi18n::loaded_lang")
		_.each(Steedos.collections, (collection) ->
			collection.i18n()

			if (collection._table)
				_.each(collection._table.options.columns, (column) ->
					if (!column.data)
						return
					column.title = t(collection._table.collection._name + "_" + column.data);
				)
		)
