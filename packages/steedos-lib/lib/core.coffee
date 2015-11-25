###
# Kick off the global namespace for Steedos.
# @namespace Steedos
###

db = {}


Steedos =
	db: db,

if Meteor.isClient
	Steedos._timezones = _.map moment.tz.names(), (name) ->
		offset = moment.tz(name)._offset / 60 * -1;

		sign = if offset < 0 then "-" else "";
		min = Math.floor(Math.abs(offset));
		sec = Math.floor((Math.abs(offset) * 60) % 60);
		label = sign + (if min < 10 then "0" else "") + min + ":" + (if sec < 10 then "0" else "") + sec;

		return {value: name, label: "(GMT " + label + ") " + name, offset: offset};
	Steedos._timezones = _.sortBy(Steedos._timezones, 'offset');