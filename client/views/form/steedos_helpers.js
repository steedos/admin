
Steedos_Helpers = {};
Template.registerHelper("Steedos_Helpers", Steedos_Helpers);


// Useful for looping through lines in some long text, as diliniated by "\n" (newline) character
// Usage: {{#each Helpers.lineIn someLongTextString}}{{this}}<br>{{/each}}
Steedos_Helpers.lineIn = function (text) {
  return text.split("\n");
};

Steedos_Helpers.equals = function (a, b) {
  return a === b;
};

Steedos_Helpers.contains = function (a, b) {
  return _.contains(a, b);
};

Steedos_Helpers.stringifyObj = function (obj) {
  return JSON.stringify(obj, null, 2);
};