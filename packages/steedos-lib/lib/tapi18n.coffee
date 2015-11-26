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


datatables_i18n = 
	"en":
		"sEmptyTable":     "No data available in table",
		"sInfo":           "Showing _START_ to _END_ of _TOTAL_ entries",
		"sInfoEmpty":      "Showing 0 to 0 of 0 entries",
		"sInfoFiltered":   "(filtered from _MAX_ total entries)",
		"sInfoPostFix":    "",
		"sInfoThousands":  ",",
		"sLengthMenu":     "Show _MENU_ entries",
		"sLoadingRecords": "Loading...",
		"sProcessing":     "Processing...",
		"sSearch":         "Search:",
		"sZeroRecords":    "No matching records found",
		"oPaginate": 
			"sFirst":    "First",
			"sLast":     "Last",
			"sNext":     "Next",
			"sPrevious": "Previous"
		"oAria": 
			"sSortAscending":  ": activate to sort column ascending",
			"sSortDescending": ": activate to sort column descending"
		"select" : 
			"rows": "%d row(s) selected"
		
	"zh-CN":
		"sProcessing":   "处理中...",
		"sLengthMenu":   "显示 _MENU_ 项结果",
		"sZeroRecords":  "没有匹配结果",
		"sInfo":         "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
		"sInfoEmpty":    "显示第 0 至 0 项结果，共 0 项",
		"sInfoFiltered": "(由 _MAX_ 项结果过滤)",
		"sInfoPostFix":  "",
		"sSearch":       "搜索:",
		"sUrl":          "",
		"sEmptyTable":     "表中数据为空",
		"sLoadingRecords": "载入中...",
		"sInfoThousands":  ",",
		"oPaginate": 
			"sFirst":    "首页",
			"sPrevious": "上页",
			"sNext":     "下页",
			"sLast":     "末页"
		"oAria": 
			"sSortAscending":  ": 以升序排列此列",
			"sSortDescending": ": 以降序排列此列"
		"select" : 
			"rows": "选中%d行"
	


if Meteor.isClient

	Meteor.Collection.prototype.i18n = () ->

		self = this;

		if (self._c2 && self._c2._simpleSchema)
			_schema = self._c2._simpleSchema._schema;
		else
			_schema = self._simpleSchema._schema

		if (!_schema)
			return	

		_.each(_schema, (value, key) ->
			if (!value) 
				return
			_schema[key].label = t(self._name + "_" + key)
		)

	Tracker.autorun ->
		lang = Session.get("TAPi18n::loaded_lang")
		_.each db, (collection) ->
			if not collection
				return;
			if not (collection instanceof Meteor.Collection)
				return;
			collection.i18n()

			if (collection._table)
				_.each collection._table.options.columns, (column) ->
					if (!column.data)
						return
					column.title = t(collection._table.collection._name + "_" + column.data);
				collection._table.options.language = datatables_i18n[lang]
				
		
