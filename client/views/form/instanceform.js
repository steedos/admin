  steedos_form = {"_rev":13,"created":"2014-01-15T05:33:21.825Z","created_by":"5194c97ef4a5635357000011","modified":"2015-07-16T04:32:17.455Z","modified_by":"5194c66ef4a563537a000003","start_date":"2014-01-15T05:37:38.788Z","form":"75418285-8218-480A-8611-400E556F8DAB","fields":[{"name":"","code":"所在部门","is_required":false,"is_wide":true,"type":"input","rows":4,"digits":0,"formula":"{applicant.organization.fullname}","has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"D6EC2C8B-1139-4EE8-887E-5AF1BE38B73A","permission":"readonly"},{"name":"","code":"出差日期起","is_required":true,"is_wide":false,"type":"date","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"CE5923C2-37B7-4129-A6EB-D888D677DA42","permission":"editable"},{"name":"","code":"出差日期迄","is_required":true,"is_wide":false,"type":"date","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"FFE60734-54FD-472A-B110-EBA8D7983C90","permission":"editable"},{"name":"","code":"出差天数","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"8457C21A-4BD0-4787-8BDE-A602FE02BEB9","permission":"editable"},{"name":"","code":"出差地点","is_required":true,"is_wide":false,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"3C043BF0-C8EB-481E-AC37-D3B88CF2B1AA","permission":"editable"},{"name":"","code":"所属项目","is_required":false,"is_wide":true,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"58747652-7D28-45AA-8873-5037619C1BA3","permission":"editable"},{"name":"","code":"出差事由","is_required":true,"is_wide":true,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"C3AE0E13-2347-4609-9B00-30334811CE18","permission":"editable"},{"name":"","code":"行程安排","is_required":true,"is_wide":true,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"CF58B661-88CC-4E6A-B9DD-4F8AF434F63B","permission":"editable"},{"name":"","code":"同行人员","is_required":false,"is_wide":false,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"B4950DE1-09CC-4BC9-8EE8-DC9CE65B3D16","permission":"editable"},{"name":"","code":"是否同住","default_value":"","is_required":false,"is_wide":false,"type":"radio","rows":4,"digits":0,"options":"是\n否","has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"43FC9A63-4C42-4FAE-8422-7D246F0789B6","permission":"editable"},{"name":"","code":"出差费用明细","is_required":false,"is_wide":true,"type":"table","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[{"field_code":"fylb","width":150},{"field_code":"fyje","width":150},{"field_code":"bz","width":150}],"fields":[{"name":"","code":"费用类别","default_value":"","is_required":true,"is_wide":false,"type":"select","rows":4,"digits":0,"options":"飞机票\n火车票\n轮船票\n住宿费\n餐费\n公交费\n住勤补贴\n其他费用","has_others":false,"is_multiselect":false,"oldCode":"费用类别","subform_fields":[],"id":"E7FFE626-C42B-4AF6-B774-B92F937747BB","permission":"editable"},{"name":"","code":"费用金额(RMB)","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"has_others":false,"is_multiselect":false,"oldCode":"费用金额(RMB)","subform_fields":[],"id":"EF76F284-7FB2-4480-B317-C635EC3D5308","permission":"editable"},{"name":"","code":"备注","is_required":false,"is_wide":true,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"oldCode":"备注","subform_fields":[],"id":"6F36B7A8-AC3C-4D77-B62C-EBA801732BA3","permission":"editable"}],"id":"5E6FBCD6-C10B-45BC-AFCE-4C980666ED6D","permission":"editable"},{"name":"","code":"报销费用合计","is_required":false,"is_wide":false,"type":"number","rows":4,"digits":2,"formula":"sum({费用金额(RMB)})","has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"6B6BAEE6-2DE9-42F0-8A98-A08886633AFE","permission":"readonly"},{"name":"","code":"暂支金额","default_value":"0.00","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"formula":"","has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"31D6413E-095D-4329-B10F-9D0A0AB72B16","permission":"editable"},{"name":"","code":"退回","default_value":"0.00","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"has_others":false,"is_multiselect":false,"subform_fields":[],"oldCode":"退/补金额（退=负数，补=正数）","fields":[],"id":"906EC691-183F-4570-B27E-992E9FDCEFC7","permission":"editable"},{"code":"补领","default_value":"0.00","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"has_others":false,"is_multiselect":false,"subform_fields":[],"id":"8F557AE0-BC1A-4B36-885B-5E9B0DF06BC8","permission":"editable"},{"name":"","code":"实际报销金额","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"formula":"{报销费用合计}-{暂支金额}+{退回}-{补领}","has_others":false,"is_multiselect":false,"subform_fields":[],"oldCode":"实际报销金额","fields":[],"id":"0AD2C219-CABA-444F-8681-9C08B62C154F","permission":"readonly"}],"id":"31a64000-f774-42f8-819c-bb463a6e078f"};
  function sFToAF(steedosForm) {
    //af template
    var afFields = {};
    var stFields = steedosForm.fields;

    for(var i = 0; i < stFields.length; i ++){
      var stField = stFields[i];
      var afField = {};

      afField.type = String;
      afField.optional = true;
      afField.label = (stField.name !=null && stField.name.length > 0) ? stField.name : stField.code ;
      autoform = {};

      autoform.name = stField.code;
      
      autoform.type = stField.type;

      switch(stField.type){
          case 'input' :
              autoform.type = 'text';
              break;
          case 'number' :
              autoform.type = 'number'; //控制有效位数
              break;
          case 'date' :
              autoform.type = 'date';
              break;
          case 'dateTime' : 
              autoform.type = 'time'; 
              break;
          case 'checkbox' :
              autoform.type = 'boolean-checkbox';
              break;
          case 'select' : 
              autoform.type = 'select2';
              var options = new Array();

              var stOptions = stField.options.split("\n");

              for(var s = 0; s < stOptions.length; s++ ){
                options.push({'label':stOptions[s],'value':stOptions[s]});
              }

              autoform.options = options;

              break;
          case 'radio' :
              autoform.type = 'select-radio-inline';
              var options = new Array();
              var stOptions = stField.options.split("\n");

              for(var s = 0; s < stOptions.length; s++ ){
                options.push({'label':stOptions[s],'value':stOptions[s]});
              }

              autoform.options = options;

              break;
          case 'multiSelect' : 
              autoform.type = 'select-checkbox'
              var options = new Array();
              var stOptions = stField.options.split("\n");

              for(var s = 0; s < stOptions.length; s++ ){
                options.push({'label':stOptions[s],'value':stOptions[s]});
              }

              autoform.options = options;

              break;
          case 'table' :
              autoform.type = 'table';
              autoform.sfField = stField.fields;
              break;
          case 'label' :
              autoform.type = 'label';
              break; 
          default:
              break; //地理位置
      }
      afField.autoform = autoform;
      afFields[stField.code] = afField;

    }
    console.log(JSON.stringify(afFields));
    return afFields;
  };


    var form = {
        '_rev':1,'name':'请假申请单',
        'fields':[
          {'name':'','code':'请假类别','type':'options','options':'病假 事假 年假'},
          {'name':'','code':'请假天数','type':'number'},
          {'name':'','code':'报销明细','type':'table',
            'sFields':[
              {'code':'金额','type':'number'},
              {'code':'地点','type':'input'},
              {'code':'地点2','type':'input'},
              {'code':'地点3','type':'input'},
              {'code':'地点4','type':'input'},
              {'code':'地点5','type':'input'},
              {'code':'地点6','type':'input'},
              {'code':'地点7','type':'input'},
              {'code':'地点8','type':'input'}
            ]
          }
        ]
      };

    var values = {
      '请假类别':'年假',
      '请假天数':'5.5',
      '报销明细':[
        {'金额':1024,'dd':'上海'},
        {'金额':2048,'dd':'西安'}
      ],
      
    };
    var fields = sFToAF(steedos_form);
/*
    var fields = {
          '请假类别': {
            type: String,
            optional: true,
            label:'请假类别',
            autoform: {
              type: "select2",
              value: '年假',
              options: function () {
                return [
                  {label: "事假", value: '事假'},
                  {label: "年假", value: '年假'},
                  {label: "调休", value: '调休'}
                ];
              }
            }
          },
          '请假天数': {
            type: String,
            label:'请假天数',
            autoform: {
              value:0.5,
              afFieldInput: {
                type: "number",
                min:0.5,
                step:0.5
              }
            }
          },
          '报销明细': {
            type: Array,
            optional: true,
            minCount: 0,
            maxCount: 5
          },
          '报销明细.$': {
            type: Object,
            optional: true
          },
          '报销明细.$.金额': {
            type: Number,
            label: '金额',
            optional: true
          },
          '报销明细.$.地点': {
            type: String,
            label: '地点',
            optional: true
          }
          
        };
*/
    Template.instanceform.helpers({
      
      steedos_form: steedos_form,
      instance: {'NO':'请假申请单 13','请假类别':'事假','请假天数':'3'},
      equals: function(a,b) {
        return a == b;
      },
      value: function(code){
        
      return [[111,'上海','上海','上海','上海','上海','上海','上海','上海'],[222,'西安','西安','西安','西安','西安','西安','西安','西安']];
    },
    getValue: function(value , code){

      return value[code]
    },
    fields: function (){
      return new SimpleSchema(fields);
    }

  });

  Template.instanceform.events({
    // 'click button': function () {
    //   // increment the counter when button is clicked
    //   Session.set('counter', Session.get('counter') + 1);
    // }
  });


