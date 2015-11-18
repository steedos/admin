Ap = AccountsClient.prototype

Ap._storeLoginToken_Orginal = Ap._storeLoginToken
Ap._unstoreLoginToken_Orginal = Ap._unstoreLoginToken


Ap._storeLoginToken = (userId, token, tokenExpires) ->
	this._storeLoginToken_Orginal(userId, token, tokenExpires)
	domain = URI().domain()
	Cookie.set "X-Auth-Token", token,
		domain: domain,
		path: '/',
		expires: 30
	Cookie.set "X-User-Id", userId,
		domain: domain,
		path: '/',
		expires: 30
	

Ap._unstoreLoginToken = (userId, token, tokenExpires) ->
	this._unstoreLoginToken_Orginal(userId, token, tokenExpires)
	domain = URI().domain()
	Cookie.remove "X-User-Id", 
		domain: domain
	
	Cookie.remove "X-Auth-Token", 
		domain: domain
	