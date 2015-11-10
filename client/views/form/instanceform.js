  steedos_form = {"_rev":13,"created":"2014-01-15T05:33:21.825Z","created_by":"5194c97ef4a5635357000011","modified":"2015-07-16T04:32:17.455Z","modified_by":"5194c66ef4a563537a000003","start_date":"2014-01-15T05:37:38.788Z","form":"75418285-8218-480A-8611-400E556F8DAB","fields":[{"name":"","code":"所在部门","is_required":false,"is_wide":true,"type":"input","rows":4,"digits":0,"formula":"{applicant.organization.fullname}","has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"D6EC2C8B-1139-4EE8-887E-5AF1BE38B73A","permission":"readonly"},{"name":"","code":"出差日期起","is_required":true,"is_wide":false,"type":"date","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"CE5923C2-37B7-4129-A6EB-D888D677DA42","permission":"editable"},{"name":"","code":"出差日期迄","is_required":true,"is_wide":false,"type":"date","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"FFE60734-54FD-472A-B110-EBA8D7983C90","permission":"editable"},{"name":"","code":"出差天数","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"8457C21A-4BD0-4787-8BDE-A602FE02BEB9","permission":"editable"},{"name":"","code":"出差地点","is_required":true,"is_wide":false,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"3C043BF0-C8EB-481E-AC37-D3B88CF2B1AA","permission":"editable"},{"name":"","code":"所属项目","is_required":false,"is_wide":true,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"58747652-7D28-45AA-8873-5037619C1BA3","permission":"editable"},{"name":"","code":"出差事由","is_required":true,"is_wide":true,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"C3AE0E13-2347-4609-9B00-30334811CE18","permission":"editable"},{"name":"","code":"行程安排","is_required":true,"is_wide":true,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"CF58B661-88CC-4E6A-B9DD-4F8AF434F63B","permission":"editable"},{"name":"","code":"同行人员","is_required":false,"is_wide":false,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"B4950DE1-09CC-4BC9-8EE8-DC9CE65B3D16","permission":"editable"},{"name":"","code":"是否同住","default_value":"","is_required":false,"is_wide":false,"type":"radio","rows":4,"digits":0,"options":"是\n否","has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"43FC9A63-4C42-4FAE-8422-7D246F0789B6","permission":"editable"},{"name":"","code":"出差费用明细","is_required":false,"is_wide":true,"type":"table","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"subform_fields":[{"field_code":"fylb","width":150},{"field_code":"fyje","width":150},{"field_code":"bz","width":150}],"sfields":[{"name":"","code":"费用类别","default_value":"","is_required":true,"is_wide":false,"type":"select","rows":4,"digits":0,"options":"飞机票\n火车票\n轮船票\n住宿费\n餐费\n公交费\n住勤补贴\n其他费用","has_others":false,"is_multiselect":false,"oldCode":"费用类别","subform_fields":[],"id":"E7FFE626-C42B-4AF6-B774-B92F937747BB","permission":"readonly"},{"name":"","code":"费用金额(RMB)","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"has_others":false,"is_multiselect":false,"oldCode":"费用金额(RMB)","subform_fields":[],"id":"EF76F284-7FB2-4480-B317-C635EC3D5308","permission":"editable"},{"name":"","code":"备注","is_required":false,"is_wide":true,"type":"input","rows":4,"digits":0,"has_others":false,"is_multiselect":false,"oldCode":"备注","subform_fields":[],"id":"6F36B7A8-AC3C-4D77-B62C-EBA801732BA3","permission":"editable"}],"id":"5E6FBCD6-C10B-45BC-AFCE-4C980666ED6D","permission":"editable"},{"name":"","code":"报销费用合计","is_required":false,"is_wide":false,"type":"number","rows":4,"digits":2,"formula":"sum({费用金额(RMB)})","has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"6B6BAEE6-2DE9-42F0-8A98-A08886633AFE","permission":"readonly"},{"name":"","code":"暂支金额","default_value":"0.00","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"formula":"","has_others":false,"is_multiselect":false,"subform_fields":[],"fields":[],"id":"31D6413E-095D-4329-B10F-9D0A0AB72B16","permission":"editable"},{"name":"","code":"退回","default_value":"0.00","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"has_others":false,"is_multiselect":false,"subform_fields":[],"oldCode":"退/补金额（退=负数，补=正数）","fields":[],"id":"906EC691-183F-4570-B27E-992E9FDCEFC7","permission":"editable"},{"code":"补领","default_value":"0.00","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"has_others":false,"is_multiselect":false,"subform_fields":[],"id":"8F557AE0-BC1A-4B36-885B-5E9B0DF06BC8","permission":"editable"},{"name":"","code":"实际报销金额","is_required":true,"is_wide":false,"type":"number","rows":4,"digits":2,"formula":"{报销费用合计}-{暂支金额}+{退回}-{补领}","has_others":false,"is_multiselect":false,"subform_fields":[],"oldCode":"实际报销金额","fields":[],"id":"0AD2C219-CABA-444F-8681-9C08B62C154F","permission":"readonly"}],"id":"31a64000-f774-42f8-819c-bb463a6e078f"};
  instance = {"space":"51ae9b1a8e296a29c9000001","flow":"C4D03B80-1CE1-4DD9-ABE4-19D58A064941","flow_version":"e1ccb661-1dc3-4141-ba16-0822f0773472","form":"75418285-8218-480A-8611-400E556F8DAB","form_version":"31a64000-f774-42f8-819c-bb463a6e078f","name":"出差费用报销 49","submitter":"51a842c87046900538000001","submitter_name":"包周涛","applicant":"51a842c87046900538000001","applicant_name":"包周涛","applicant_organization":"51aefb658e296a29c9000049","applicant_organization_name":"研发部","applicant_organization_fullname":"华炎软件/研发部","submit_date":"2015-09-02T06:14:09.569Z","state":"completed","final_decision":"approved","code":"49","is_archived":true,"is_deleted":false,"values":{"所在部门":"华炎软件/研发部","出差日期起":"2015-08-25","出差日期迄":"2015-08-29","出差天数":"5","出差地点":"秦皇岛","所属项目":"秦皇岛OA","出差事由":"秦皇岛OA升级","行程安排":"秦皇岛OA升级；处理秦皇岛门户平台中报表显示异常问题","同行人员":"黄怡","是否同住":"否","出差费用明细":[{"费用类别":"公交费","费用金额(RMB)":"33.00","备注":"九亭-虹桥火车站"},{"费用类别":"火车票","费用金额(RMB)":"612.00","备注":"上海虹桥-秦皇岛"},{"费用类别":"公交费","费用金额(RMB)":"20.00","备注":"秦皇岛火车站-秦皇岛港务局"},{"费用类别":"住宿费","费用金额(RMB)":"605.00","备注":"160*3 + 125*1"},{"费用类别":"火车票","费用金额(RMB)":"621.50","备注":"山海关-上海虹桥"},{"费用类别":"公交费","费用金额(RMB)":"40.00","备注":"上海虹桥-九亭大街"},{"费用类别":"住勤补贴","费用金额(RMB)":"250.00","备注":"50*5"}],"报销费用合计":2181.5,"暂支金额":"0.00","退回":"0.00","补领":"0.00","实际报销金额":2181.5},"inbox_users":[],"outbox_users":["51a842c87046900538000001","5199da568e296a4ba0000003","5194c66ef4a563537a000003"],"modified":"2015-09-11T06:29:48.108Z","modified_by":"51a842c87046900538000001","created":"2015-09-02T06:01:42.814Z","created_by":"51a842c87046900538000001","traces":[{"instance":"55e690c6527eca6cab000801","previous_trace_ids":[],"is_finished":true,"step":"0C8693C6-2538-4EFD-B85E-AB9016F0F369","start_date":"2015-09-02T06:01:42.814Z","finish_date":"2015-09-02T06:14:09.566Z","judge":"submitted","approves":[{"instance":"55e690c6527eca6cab000801","trace":"55e690c6527eca6cab000802","is_finished":true,"user":"51a842c87046900538000001","user_name":"包周涛","handler":"51a842c87046900538000001","handler_name":"包周涛","handler_organization":"51aefb658e296a29c9000049","handler_organization_name":"研发部","handler_organization_fullname":"华炎软件/研发部","type":"draft","start_date":"2015-09-02T06:01:42.814Z","finish_date":"2015-09-02T06:14:09.566Z","read_date":"2015-09-02T06:01:42.815Z","judge":"submitted","is_read":true,"description":"","values":{"出差日期起":"2015-08-25","出差日期迄":"2015-08-29","出差天数":"5","出差地点":"秦皇岛","所属项目":"秦皇岛OA","出差事由":"秦皇岛OA升级","行程安排":"秦皇岛OA升级；处理秦皇岛门户平台中报表显示异常问题","同行人员":"黄怡","是否同住":"否","出差费用明细":[{"费用类别":"公交费","费用金额(RMB)":"33.00","备注":"九亭-虹桥火车站"},{"费用类别":"火车票","费用金额(RMB)":"612.00","备注":"上海虹桥-秦皇岛"},{"费用类别":"公交费","费用金额(RMB)":"20.00","备注":"秦皇岛火车站-秦皇岛港务局"},{"费用类别":"住宿费","费用金额(RMB)":"605.00","备注":"160*3 + 125*1"},{"费用类别":"火车票","费用金额(RMB)":"621.50","备注":"山海关-上海虹桥"},{"费用类别":"公交费","费用金额(RMB)":"40.00","备注":"上海虹桥-九亭大街"},{"费用类别":"住勤补贴","费用金额(RMB)":"250.00","备注":"50*5"}],"暂支金额":"0.00","退回":"0.00","补领":"0.00"},"next_steps":[{"step":"d8a13de2-f5b3-4dad-b204-b06aed6a7f08","users":["5194c66ef4a563537a000003"]}],"is_error":false,"id":"55e690c6527eca6cab000803"}],"id":"55e690c6527eca6cab000802"},{"instance":"55e690c6527eca6cab000801","previous_trace_ids":["55e690c6527eca6cab000802"],"is_finished":true,"step":"d8a13de2-f5b3-4dad-b204-b06aed6a7f08","start_date":"2015-09-02T06:14:09.566Z","finish_date":"2015-09-02T07:41:33.639Z","due_date":"2015-09-09T06:14:09.566Z","judge":"approved","approves":[{"instance":"55e690c6527eca6cab000801","trace":"55e693b1527eca6cab000853","is_finished":true,"user":"5194c66ef4a563537a000003","user_name":"庄建国","handler":"5194c66ef4a563537a000003","handler_name":"庄建国","handler_organization":"51aefb4f8e296a29c9000048","handler_organization_name":"总经办","handler_organization_fullname":"华炎软件 / 总经办","start_date":"2015-09-02T06:14:09.568Z","finish_date":"2015-09-02T07:41:33.639Z","due_date":"2015-09-09T06:14:09.566Z","read_date":"2015-09-02T07:41:33.535Z","judge":"approved","is_read":true,"values":{"所在部门":"华炎软件/研发部","出差日期起":"2015-08-25","出差日期迄":"2015-08-29","出差天数":"5","出差地点":"秦皇岛","所属项目":"秦皇岛OA","出差事由":"秦皇岛OA升级","行程安排":"秦皇岛OA升级；处理秦皇岛门户平台中报表显示异常问题","同行人员":"黄怡","是否同住":"否","出差费用明细":[{"费用类别":"公交费","费用金额(RMB)":"33.00","备注":"九亭-虹桥火车站"},{"费用类别":"火车票","费用金额(RMB)":"612.00","备注":"上海虹桥-秦皇岛"},{"费用类别":"公交费","费用金额(RMB)":"20.00","备注":"秦皇岛火车站-秦皇岛港务局"},{"费用类别":"住宿费","费用金额(RMB)":"605.00","备注":"160*3 + 125*1"},{"费用类别":"火车票","费用金额(RMB)":"621.50","备注":"山海关-上海虹桥"},{"费用类别":"公交费","费用金额(RMB)":"40.00","备注":"上海虹桥-九亭大街"},{"费用类别":"住勤补贴","费用金额(RMB)":"250.00","备注":"50*5"}],"报销费用合计":2181.5,"暂支金额":"0.00","退回":"0.00","补领":"0.00","实际报销金额":2181.5},"next_steps":[{"step":"44934215-fd56-4cf8-b489-f8fb8f94b38a","users":["51a842c87046900538000001"]}],"is_error":false,"id":"55e693b1527eca6cab000854"}],"id":"55e693b1527eca6cab000853"},{"instance":"55e690c6527eca6cab000801","previous_trace_ids":["55e693b1527eca6cab000853"],"is_finished":true,"step":"44934215-fd56-4cf8-b489-f8fb8f94b38a","start_date":"2015-09-02T07:41:33.639Z","finish_date":"2015-09-07T01:36:13.988Z","judge":"submitted","approves":[{"instance":"55e690c6527eca6cab000801","trace":"55e6a82d527eca6cab000a14","is_finished":true,"user":"51a842c87046900538000001","user_name":"包周涛","handler":"51a842c87046900538000001","handler_name":"包周涛","handler_organization":"51aefb658e296a29c9000049","handler_organization_name":"研发部","handler_organization_fullname":"华炎软件 / 研发部","start_date":"2015-09-02T07:41:33.641Z","finish_date":"2015-09-07T01:36:13.988Z","read_date":"2015-09-02T09:50:34.253Z","judge":"submitted","is_read":true,"values":{"出差费用明细":[{},{},{},{},{},{},{}]},"next_steps":[{"step":"13925f58-f1eb-4635-adf2-910a6fa06c54","users":["5199da568e296a4ba0000003"]}],"is_error":false,"id":"55e6a82d527eca6cab000a15"}],"id":"55e6a82d527eca6cab000a14"},{"instance":"55e690c6527eca6cab000801","previous_trace_ids":["55e6a82d527eca6cab000a14"],"is_finished":true,"step":"13925f58-f1eb-4635-adf2-910a6fa06c54","start_date":"2015-09-07T01:36:13.988Z","finish_date":"2015-09-07T03:25:27.802Z","judge":"approved","approves":[{"instance":"55e690c6527eca6cab000801","trace":"55ecea0d527eca0f0d0009ef","is_finished":true,"user":"5199da568e296a4ba0000003","user_name":"刘恋","handler":"5199da568e296a4ba0000003","handler_name":"刘恋","handler_organization":"51aefb888e296a29c900004b","handler_organization_name":"总务部","handler_organization_fullname":"华炎软件/总务部","start_date":"2015-09-07T01:36:13.990Z","finish_date":"2015-09-07T03:25:27.802Z","read_date":"2015-09-07T03:25:27.415Z","judge":"approved","is_read":true,"values":{"所在部门":"华炎软件/研发部","出差日期起":"2015-08-25","出差日期迄":"2015-08-29","出差天数":"5","出差地点":"秦皇岛","所属项目":"秦皇岛OA","出差事由":"秦皇岛OA升级","行程安排":"秦皇岛OA升级；处理秦皇岛门户平台中报表显示异常问题","同行人员":"黄怡","是否同住":"否","出差费用明细":[{"费用类别":"公交费","费用金额(RMB)":"33.00","备注":"九亭-虹桥火车站"},{"费用类别":"火车票","费用金额(RMB)":"612.00","备注":"上海虹桥-秦皇岛"},{"费用类别":"公交费","费用金额(RMB)":"20.00","备注":"秦皇岛火车站-秦皇岛港务局"},{"费用类别":"住宿费","费用金额(RMB)":"605.00","备注":"160*3 + 125*1"},{"费用类别":"火车票","费用金额(RMB)":"621.50","备注":"山海关-上海虹桥"},{"费用类别":"公交费","费用金额(RMB)":"40.00","备注":"上海虹桥-九亭大街"},{"费用类别":"住勤补贴","费用金额(RMB)":"250.00","备注":"50*5"}],"报销费用合计":2181.5,"暂支金额":"0.00","退回":"0.00","补领":"0.00","实际报销金额":2181.5},"next_steps":[{"step":"6e4d0efb-d8e7-470f-be05-35aafb63b6f3","users":["5199da568e296a4ba0000003"]}],"is_error":false,"id":"55ecea0d527eca0f0d0009f0"}],"id":"55ecea0d527eca0f0d0009ef"},{"instance":"55e690c6527eca6cab000801","previous_trace_ids":["55ecea0d527eca0f0d0009ef"],"is_finished":true,"step":"6e4d0efb-d8e7-470f-be05-35aafb63b6f3","start_date":"2015-09-07T03:25:27.802Z","finish_date":"2015-09-10T04:21:16.023Z","judge":"submitted","approves":[{"instance":"55e690c6527eca6cab000801","trace":"55ed03a7527eca0f0d000d40","is_finished":true,"user":"5199da568e296a4ba0000003","user_name":"刘恋","handler":"5199da568e296a4ba0000003","handler_name":"刘恋","handler_organization":"51aefb888e296a29c900004b","handler_organization_name":"总务部","handler_organization_fullname":"华炎软件/总务部","start_date":"2015-09-07T03:25:27.805Z","finish_date":"2015-09-10T04:21:16.023Z","read_date":"2015-09-07T03:25:31.627Z","judge":"submitted","is_read":true,"values":{"出差费用明细":[{},{},{},{},{},{},{}]},"next_steps":[{"step":"b7a35672-d4ab-4b72-9016-c89c4943ac15","users":["51a842c87046900538000001"]}],"is_error":false,"id":"55ed03a7527eca0f0d000d41"}],"id":"55ed03a7527eca0f0d000d40"},{"instance":"55e690c6527eca6cab000801","previous_trace_ids":["55ed03a7527eca0f0d000d40"],"is_finished":true,"step":"b7a35672-d4ab-4b72-9016-c89c4943ac15","start_date":"2015-09-10T04:21:16.023Z","finish_date":"2015-09-10T06:17:53.401Z","judge":"approved","approves":[{"instance":"55e690c6527eca6cab000801","trace":"55f1053c527eca227800135a","is_finished":true,"user":"51a842c87046900538000001","user_name":"包周涛","handler":"51a842c87046900538000001","handler_name":"包周涛","handler_organization":"51aefb658e296a29c9000049","handler_organization_name":"研发部","handler_organization_fullname":"华炎软件 / 研发部","start_date":"2015-09-10T04:21:16.027Z","finish_date":"2015-09-10T06:17:53.401Z","read_date":"2015-09-10T06:17:53.304Z","judge":"approved","is_read":true,"values":{"所在部门":"华炎软件/研发部","出差日期起":"2015-08-25","出差日期迄":"2015-08-29","出差天数":"5","出差地点":"秦皇岛","所属项目":"秦皇岛OA","出差事由":"秦皇岛OA升级","行程安排":"秦皇岛OA升级；处理秦皇岛门户平台中报表显示异常问题","同行人员":"黄怡","是否同住":"否","出差费用明细":[{"费用类别":"公交费","费用金额(RMB)":"33.00","备注":"九亭-虹桥火车站"},{"费用类别":"火车票","费用金额(RMB)":"612.00","备注":"上海虹桥-秦皇岛"},{"费用类别":"公交费","费用金额(RMB)":"20.00","备注":"秦皇岛火车站-秦皇岛港务局"},{"费用类别":"住宿费","费用金额(RMB)":"605.00","备注":"160*3 + 125*1"},{"费用类别":"火车票","费用金额(RMB)":"621.50","备注":"山海关-上海虹桥"},{"费用类别":"公交费","费用金额(RMB)":"40.00","备注":"上海虹桥-九亭大街"},{"费用类别":"住勤补贴","费用金额(RMB)":"250.00","备注":"50*5"}],"报销费用合计":2181.5,"暂支金额":"0.00","退回":"0.00","补领":"0.00","实际报销金额":2181.5},"next_steps":[{"step":"3F08CD51-420B-4F3B-A3B9-9300D272AAB4","users":[]}],"is_error":false,"id":"55f1053c527eca227800135b"}],"id":"55f1053c527eca227800135a"},{"instance":"55e690c6527eca6cab000801","previous_trace_ids":["55f1053c527eca227800135a"],"is_finished":true,"step":"3F08CD51-420B-4F3B-A3B9-9300D272AAB4","start_date":"2015-09-10T06:17:53.401Z","finish_date":"2015-09-10T06:17:53.401Z","approves":[],"id":"55f12091527eca2278001563"}],"attachments":[],"id":"55e690c6527eca6cab000801"};
  function sFToAF(steedosForm) {
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
          afFields[stField.code + ".$." + sstField.code] = new s_schema(String, sstField.code, sstField.type, sstField.options, sstField.permission, sstField.is_required);
          
        }

        afFields[stField.code].autoform.sfieldcodes = sfieldcodes;

      }else{
        
        afFields[stField.code] = new s_schema(String, label, stField.type, stField.options, stField.permission, stField.is_required);
      
      }
    }
    console.log(JSON.stringify(afFields));
    return afFields;
  }

  function s_schema(schematype, label, fieldType, options, permission, is_required){

    schema = {type:schematype};
   
    schema.label = label;
    schema.defaultValue = '1111';
    schema.optional = !is_required;

    if(fieldType == 'email'){
      debugger;
      schema.regEx = SimpleSchema.RegEx.Email;
    }else if (fieldType == 'url'){

      schema.regEx = SimpleSchema.RegEx.Url;

    }

    schema.autoform = new s_autoform(fieldType, options, permission);
    return schema;
  }

  function s_autoform(type, options, permission){
    autoform = {};
    
    //字段类型转换
    switch(type){
      case 'input' :
            autoform.readonly = (permission == 'readonly');
            autoform.type = 'text';
            break;
        case 'number' :
            autoform.readonly = (permission == 'readonly');
            autoform.type = 'number'; //控制有效位数
            break;
        case 'date' :
            autoform.readonly = (permission == 'readonly');
            autoform.type = 'date';
            break;
        case 'dateTime' : 
            autoform.readonly = (permission == 'readonly');
            autoform.type = 'time'; 
            break;
        case 'checkbox' :
            autoform.disabled = (permission == 'readonly');
            autoform.type = 'boolean-checkbox';
            break;
        case 'select' : 
            autoform.readonly = (permission == 'readonly');
            autoform.type = (permission == 'readonly') ? 'text' : 'select2';
            break;
        case 'radio' :
            autoform.disabled = (permission == 'readonly');
            autoform.type = 'select-radio-inline';
            break;
        case 'multiSelect' : 
            autoform.disabled = (permission == 'readonly');
            autoform.type = 'select-checkbox-inline';
            break;
        default:
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
    }
    return autoform;
  }

  function get_subFormValue(code,values){
      var subV = values[code];
      var rev_sub = new Array();

      var sfieldcodes = fields[code].autoform.sfieldcodes;
      
      for(var i = 0 ; i < subV.length; i++){
        var sfv = new Array();
        for(f in sfieldcodes){
          if (subV[i][sfieldcodes[f]])
            sfv.push(subV[i][sfieldcodes[f]]);
          else
            sfv.push('');
      
        }
      
        rev_sub.push(sfv);
      
      }
      
      return rev_sub;
  }

  function update_subFormView(code,values){
    console.log("update_subFormView s")
    console.log(values);
    var subFormTBody = '';

    for(var r = 0; r < values.length; r++){
      subFormTBody = subFormTBody + '<tr>'
      for(var c = 0; c < values[r].length; c++){
          subFormTBody = subFormTBody + '<td>' + values[r][c] + '</td>';
      }
      subFormTBody = subFormTBody + '</tr>'
    }
    console.log("subFormTBody");
    console.log(subFormTBody);
    $("#"+code+'tbody').html(subFormTBody);
  } 

  var fields = sFToAF(steedos_form);

  Template.instanceform.helpers({
    
    steedos_form: steedos_form,
    instance: instance,
    equals: function(a,b) {
      return Steedos_Helpers.equals(a,b);
    },
    subformValue: function(code){
      return get_subFormValue(code, instance.values);
    },
    fields: function (){
      return new SimpleSchema(fields);
    },
    doc: function (){
      return instance.values;
    }
  });

  Template.instanceform.events({
    // 'click button': function () {
    //   // increment the counter when button is clicked
    //   Session.set('counter', Session.get('counter') + 1);
    // }
    'click #submit': function(){

    },

    'click #au-sb-ok': function(){
      update_subFormView("出差费用明细",get_subFormValue("出差费用明细",AutoForm.getFormValues("instanceform").insertDoc));
    }
  });


