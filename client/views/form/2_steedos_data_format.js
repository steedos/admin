Steedos_data_format = {};

//获取user select2 标签的 options
var getSpaceUserSelect2Options = function (spaceId){

  // todo Steedos_data.getSpaceUsers(spaceId);
  // 数据格式转换
  var p_rev = [
    {
      optgroup: "研发部",
      options: [
        {label: "包周涛(baozhoutao@hotoa.com)", value: "baozhoutao@hotoa.com"},
        {label: "孙浩林(sunhaolin@hotoa.com)", value: "sunhaolin@hotoa.com"},
        {label: "小强(xiaoqiang@hotoa.com)", value: "xiaoqiang@hotoa.com"}
      ]
    },
    {
      optgroup: "客服部",
      options: [
        {label: "黄怡(huangyi@hotoa.com)", value: "huangyi@hotoa.com"},
        {label: "刘恋(liulian@hotoa.com)", value: "liulian@hotoa.com"},
        {label: "小李(xiaoli@hotoa.com)", value: "xiaoli@hotoa.com"}
      ]
    }
  ];
  var rev = new Array();
  for(var i = 0 ; i < 100 ; i++){
    rev = rev.concat(p_rev);
  }

  return rev ;

};

//获取group select2 标签的 options
var getSpaceOrganizationSelect2Options = function(){

};

var s_autoform = function (schema, field){

  type = field.type;

  options = field.options;

  permission = field.permission;

  if (field["formula"])
    permission = "readonly";

  autoform = {};
    
  //字段类型转换
  switch(type){
    case 'input' :
          schema.type = String;
          autoform.readonly = (permission == 'readonly');
          autoform.type = 'text';
          break;
      case 'number' :
          schema.type = Number;
          autoform.readonly = (permission == 'readonly');
          autoform.type = 'number'; //控制有效位数
          break;
      case 'date' :
          schema.type = String;
          autoform.readonly = (permission == 'readonly');
          autoform.type = 'date';
          break;
      case 'dateTime' : 
          schema.type = String;
          autoform.readonly = (permission == 'readonly');
          autoform.type = 'time'; 
          break;
      case 'checkbox' :
          schema.type = String;
          autoform.disabled = (permission == 'readonly');
          autoform.type = 'boolean-checkbox';
          break;
      case 'select' : 
          schema.type = String;
          autoform.readonly = (permission == 'readonly');
          autoform.type = (permission == 'readonly') ? 'text' : 'select2';
          break;
      case 'radio' :
          schema.type = String;
          autoform.disabled = (permission == 'readonly');
          autoform.type = 'select-radio-inline';
          break;
      case 'multiSelect' : 
          schema.type = String;
          autoform.disabled = (permission == 'readonly');
          autoform.type = 'select-checkbox-inline';
          break;
      case 'user' : 
          schema.type = String;
          autoform.type = "select2";
          autoform.options = getSpaceUserSelect2Options("5656fdsafsfsdfsa6f5as899fds8f");
          autoform.multiple = true;
          break;
      default:
          schema.type = String;
          autoform.readonly = (permission == 'readonly');
          autoform.type = type;
          break; //地理位置
  }
  
  if (options != null && options.length > 0){

    var afoptions = new Array();
    var optionsArr = options.split("\n");

    for(var s = 0; s < optionsArr.length; s++ ){
      afoptions.push({label:optionsArr[s],value:optionsArr[s]});
    }

    autoform.options = afoptions;
    //autoform.defaultValue = '飞机票';
  }
  return autoform;
};

var s_schema = function (label, field){

  var fieldType = field.fieldType, is_required = field.is_required;

  schema = {};
   
  schema.label = label;
  //schema.defaultValue = '飞机票';
  schema.optional = !is_required;

  if(fieldType == 'email'){
    debugger;
    schema.regEx = SimpleSchema.RegEx.Email;
  }else if (fieldType == 'url'){

    schema.regEx = SimpleSchema.RegEx.Url;

  }

  schema.autoform = new s_autoform(schema, field);
  return schema;
};

Steedos_data_format.getAutoformSchema = function (steedosForm){
  var afFields = {};
  var stFields = steedosForm.fields;

  for(var i = 0; i < stFields.length; i ++){

    var stField = stFields[i];

    var label = (stField.name !=null && stField.name.length > 0) ? stField.name : stField.code ;
   
    if (stField.type == 'table'){
      
      afFields[stField.code] = {
                                  type : Array,
                                  optional : false,
                                  minCount : 0,
                                  maxCount : 200,
                                  autoform : {sfieldcodes:[]}
                                };

      afFields[stField.code + ".$"] = {
                                        type:Object,
                                        optional:false
                                      };

      var sfieldcodes = new Array();
      for(var si = 0 ; si < stField.sfields.length; si++){
       
        var sstField = stField.sfields[si];
        
        sfieldcodes.push(sstField.code);

        afFields[stField.code + ".$." + sstField.code] = new s_schema(sstField.code, sstField);
        
      }

      afFields[stField.code].autoform.sfieldcodes = sfieldcodes;

    }else{
      
      afFields[stField.code] = new s_schema(label, stField);
    
    }
  }
  console.log("afFields is");
  console.log(JSON.stringify(afFields));
  return afFields;
};
