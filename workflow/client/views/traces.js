
var formatStr = "yyyy-MM-dd HH:mm";

Template.instance_traces.helpers({

  equals: function(a,b) {
    return a === b;
  },

  isNotNull: function(a){
    if (a)
        return a.trim().length > 0;
    else
        return false;
  },

  append: function(a,b) {
    return a + b ;
  },

  dateFormat: function(date){
    return $.format.date(new Date(date), formatStr);
  },

  getStepName: function(stepId){
    var step =Steedos_data.getStep('flowId' ,stepId);
    return step.name;
  },

  getApproveStatusIcon:function(approveJudge){
    //已结束的显示为核准/驳回/取消申请，并显示处理状态图标
    var approveStatusIcon;

    switch(approveJudge){
        case 'approved':
            approveStatusIcon = 'glyphicon glyphicon-ok';
            break;
        case 'rejected':
            approveStatusIcon = 'glyphicon glyphicon-remove';
            break;
        case 'terminated':
            approveStatusIcon = '';
            break;
        case 'reassigned':
            approveStatusIcon = 'glyphicon glyphicon-share-alt';
            break;
        default:
            approveStatusIcon = '';
            break;
    }
    return approveStatusIcon;
  },

  getApproveStatusText: function(approveJudge){
    //已结束的显示为核准/驳回/取消申请，并显示处理状态图标
    var approveStatusText;

    switch(approveJudge){
        case 'approved':
            approveStatusText = "已核准";
            break;
        case 'rejected':
            approveStatusText = "已驳回";
            break;
        case 'terminated':
            approveStatusText = "已取消";
            break;
        case 'reassigned':
            approveStatusText = "转签核";
            break;
        default:
            approveStatusText = "";
            break;
    }
    return approveStatusText;
  }

});