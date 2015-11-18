tough = Npm.require('tough-cookie')

#just for test
WebApp.connectHandlers.use '/steedos/onLogin', (req, res) ->
	res.statusCode = 302;
	#res.setHeader('Location', 'http://' + req.headers['host'] + ('/' !== req.url)? ( '/' + req.url) : '');
	res.setHeader 'Location', "http://www.bing.com"
	res.end();