
Instanceform_Helpers = {};
Template.registerHelper("Instanceform_Helpers", Instanceform_Helpers);


Instanceform_Helpers.lineIn = function (text) {
  return text.split("\n");
};

Instanceform_Helpers.equals = function (a, b) {
  return a === b;
};

Instanceform_Helpers.contains = function (a, b) {
  return _.contains(a, b);
};

Instanceform_Helpers.stringifyObj = function (obj) {
  return JSON.stringify(obj, null, 2);
};





