
Instanceform_Helpers = {};
Template.registerHelper("Instanceform_Helpers", Instanceform_Helpers);


// Useful for looping through lines in some long text, as diliniated by "\n" (newline) character
// Usage: {{#each Helpers.lineIn someLongTextString}}{{this}}<br>{{/each}}
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

Instanceform_Helpers.get_subFormValue = function (code, fields, values){
  var subV = values[code];
  var rev_sub = new Array();

  var sfieldcodes = fields[code].autoform.sfieldcodes;
  for(var i = 0 ; i < subV.length; i++){
    var sfv = new Array();
    for(var j = 0; j < sfieldcodes.length; j++){
      if (subV[i][sfieldcodes[j]])
        sfv.push(subV[i][sfieldcodes[j]]);
      else
        sfv.push('');
  
    }
  
    rev_sub.push(sfv);
  
  }
  return subV;
};

Instanceform_Helpers.update_subFormView = function (code, fields, Formvalues){

  var values = Instanceform_Helpers.get_subFormValue(code, fields, Formvalues);
  
  var subFormTBody = '';

  for(var r = 0; r < values.length; r++){
    subFormTBody = subFormTBody + '<tr>'
    for(var c = 0; c < values[r].length; c++){
        subFormTBody = subFormTBody + '<td>' + values[r][c] + '</td>';
    }
    
    subFormTBody = subFormTBody + '</tr>'
  }
  $("#"+code+'tbody').html(subFormTBody);
};



