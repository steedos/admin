
Router.route '/workflow/instance/:instance_id', ->
	this.render('instanceform');


Router.route '/workflow/pending', ->
	this.render('instance_list');
