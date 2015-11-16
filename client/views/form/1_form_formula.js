Form_formula = {};

/*
    该函数实现把公式串中所有的表单字段加上__values前缀，并把花括号替换成中括号
    即把{字段名}替换成__values["字段名"]，
    子表字段{主表字段名.子表字段名}替换成__values["主表字段名"]["子表字段名"]，
    如果出现{字段名1}.{字段名2}会被替换成__values["字段名1"].__values["字段名2"]，
    字段名内的符号支持空格符，回车符，中英文，甚至纯数字在内的任意字符，
    其中字段名左右两侧如果有空格符，会被清除掉，
    但是中间的回车、空格等符号会保留。
    注意单引号及双引号内的字段名没有被排除，即只要是在花括号内的字符都会进行相关替换。
    另外目前这种做法不支持if/while等本身语句就带花括号符的写法
    参数prefix表示要加上的前缀串，即__values,参数fieldVariable表示要被替换的公式串，即formulaStr。
    在浏览器控制台中输入以下代码并执行可进行调试测试。
    var formulaStr = "{ 字 段1}={字段1 .字段2 };{字段1}={字段1}.{字段2};{字\n段1}={字段2}+1;{字段2}=sum({字段2});{字段2}='{字段2}',f8=\"{字段2}+{字段1}\";{字段1},f7=({字段1}+1),{字段2}=true;err={字段2}/{字段1};sum({字段1}；count({字段1.字段2})";
    CS.Utils.prependPrefixForFormula("__values",formulaStr)
*/
Form_formula.prependPrefixForFormula = function(prefix,fieldVariable){
    console.debug("进入prependPrefixForFormula");
    var startTrack = new Date *1;
    
    var reg = /(\{[^{}]*\})/g;//匹配包括花括号自身在内的所有符号
    rev = fieldVariable.replace(reg,function(m,$1){
        //参数$1表示正则reg匹配到的每个item，即每对{}内的符号，并且包括花括号本身
        //把reg匹配到的每个item替换成带__values前缀，同时把花括号替换成中括号，并把其中的点号替换成][
        //同时把字段名左右两侧的空格符替换成空字符
        return prefix + $1.replace(/\{\s*/,"[\"").replace(/\s*\}/,"\"]").replace(/\s*\.\s*/g,"\"][\"");
    })

    console.debug("return value : " + rev);
    console.debug("退出 prependPrefixForFormula");
    console.debug("消耗时间：" + (new Date() * 1 - startTrack) + "ms");
    return rev;
};
//return [Object]; Object["code"] , Object["formula"]
Form_formula.getFormulaFieldVariable = function(prefix,fields){
    console.debug("进入 getFormulaFieldVariable");
    var startTrack = new Date *1;
    if (!fields) return ;
    var formulas = new Array();
    for(var i = 0; i <fields.length; i++){
        var formula = new Object();
        var field = fields[i];

        if (field.type != "table"&&field.type != "section"){
            if (field.formula && field.formula!=''){
                formula["code"] = field.code;
                formula["formula"] = '{' + field.code + '}=' + field.formula + ";"
                formulas.push(formula);
            }
        }else if(field.type=="section"){
            var sectionFields = field.fields;
            if(sectionFields) {
                for(var k=0;k<sectionFields.length;k++){
                    if(sectionFields[k].formula && sectionFields[k].formula != ''){
                        var formula = new Object();
                        formula["code"] = sectionFields[k].code;
                        formula["formula"] = '{' + sectionFields[k].code + '}=' + sectionFields[k].formula + ";"
                        formulas.push(formula);
                    }
                }
            }
        }
    }
    //排序
    var i=formulas.length,j;
    var sort_key;
    while(i > 0){
        for(j=0;j<i-1;j++){
            sort_key = formulas[j];
            field_code = sort_key["code"];
            if (!Form_formula.codeIsUseInFormula(field_code,formulas[j+1]["formula"])){
                formulas[j] = formulas[j + 1];
                formulas[j + 1] = sort_key; //如果当前字段被上一个字段的公式引用， 则当前字段与上个字段的位置互换
            }
        }
        i--;
    }

    for(var j = 0 ; j < formulas.length; j++){
        //给公式添加前缀
        formulas[j]["formula"] = Form_formula.prependPrefixForFormula(prefix,formulas[j]["formula"]);
    }
    
    console.debug("退出 getFormulaFieldVariable 消耗时间：" + (new Date() * 1 - startTrack) + "ms");
    return formulas;
};
/**
* 判断传入参数code在formula中是否被引用
*/
Form_formula.codeIsUseInFormula = function(code,formula){
    if(code&&formula){
        
        //只有formula的长度大于code才可能会被引用
        //普通字段code
        var code2 = "{" + code + "}" ; 

        //如果code和formula相等 则表示直接被引用
        if(code2==formula){
            return true;
        }

        if(formula.length>code2.length){
            var splitFormula = formula.split(code2);
            
            for (var m = splitFormula.length - 2; m >= 0; m--) {
                var code_position = formula.search(code2);
                var pre_char = formula.charAt(code_position-1);
                var aft_char = formula.charAt(code_position+code2.length);
                if (pre_char.match(/\w/) == null && aft_char.match(/\w/) == null){
                    return true;
                }
            }   
        }
        //选人选组
        var code3 = "{" + code + "." ;
        if(formula.length>code3.length){
            var splitFormula = formula.split(code3);
            
            for (var m = splitFormula.length - 2; m >= 0; m--) {
                var code_position = formula.search(code3);
                var pre_char = formula.charAt(code_position-1);
                if (pre_char.match(/\w/) == null){
                    return true;
                }
            }   
        }
    }
    return false;
};

Form_formula.mixin = function(dest, src){
    for(var key in src){
        dest[key] = src[key];
    }
    return dest;
};
Form_formula.formula_values = null;

Form_formula.run = function(code, formula_fields, autoFormDoc, fields){
    var run = false;
    for(var i = 0 ; i < formula_fields.length; i++){
        formula_field = formula_fields[i];
        if (formula_field.formula.indexOf("[" + code + "]")){
            run = true;
        }

        if(run){
            if (!Form_formula.formula_values || true){
                console.debug("Form_formula.init_formula_values: 重新计算formula_values");
                var startTrack = new Date * 1;
                Form_formula.formula_values = init_formula_values(fields,autoFormDoc);
                console.debug("Form_formula.init_formula_values: 退出计算formula_values 消耗时间：" + (new Date * 1 - startTrack) + "ms");
            }

            var fileValue = eval(formula_field.formula.replace(/[\r\n]+/g, '\\n'));
            $("[name='"+formula_field.code+"']").val(Form_formula.formula_values[formula_field.code]);
        }
    }
};

/**
    * 获得公式需要用到的初始值
    * 输入：fields, values, applicant
    * 输出：__values
**/

function init_formula_values(fields, autoFormDoc){
    var __values = {};
    //申请单中填的值处理
    if(fields && fields.length && autoFormDoc) {
        //debugger;
        fields.forEach(function(field){
            var type = field.type;
            if(type) {
                if(type === 'table') {
                    /*
                    * 将表格字段的值进行转换后传入__values中
                    * values中表格的值格式为
                    * [{"a":1,"b":4},{"a":2,"b":5},{"a":3,"b":6}]
                    * __values需要转化为下面格式且和主表的值一样放到第一层
                    * {"a":[1,2,3],"b":[4,5,6]}
                    **/
                    var tableFields = field.sfields,
                        tableValues = autoFormDoc[field.code],
                        formulaTableValues = [],
                        __tableValues = {};
                    //按公式的格式转换值为__tableValues
                    if(tableFields && tableFields.length && tableValues) {
                        tableValues.forEach(function(tableValue){
                            formulaTableValues.push(init_formula_values(tableFields, tableValue));
                        }, this);
                        //按主表的格式转换__tableValues加到
                        tableFields.forEach(function(tablefield){
                            __tableValues[tablefield.code] = formulaTableValues.getEach(tablefield.code);
                        });
                        __values = Form_formula.mixin(__values, __tableValues);
                    }
                } else {
                    //此处传spaceId给选人控件的旧数据计算roles和organization
                    __values[field.code] = autoFormDoc[field.code];
                }
            }
        }, this);
    }
    //approver 当前用户
    // var currentUserId = CS.getPath('currentUser.id');
    // __approverValues = this.getUserValues(spaceId, currentUserId, 'approver');
    // //applicant 申请人
    // __applicantValues = this.getUserValues(spaceId, applicantId, 'applicant');

    // __values = SC.mixin(__values, __approverValues, __applicantValues);
    //debugger;
    return __values;
};

Array.prototype.getEach = function(code){
    var rev = [];
    for(var i = 0 ; i < this.length ; i++){
        rev.push(this[i][code]);
    }
    return rev;
};

//定义string的to_integer方法
String.prototype.to_integer = function(defaultValue)
{
    var r = parseInt(this);
    if (r||r==0) return r;
    else if(defaultValue||defaultValue==0) return defaultValue;
    else return null;
};
//定义string的to_float方法
String.prototype.to_float = function(defaultValue)
{
    var r = parseFloat(this);
    if (r||r==0) return r;
    else if(defaultValue||defaultValue==0)return defaultValue;
    else return null;
};
//定义Array的contains方法
Array.prototype.contains = function(ele)
{
    if(!ele) return false;
    var b=false;
    for(var i=0;i<this.length;i++){
        if(this[i]==ele){
            b=true;
        }
    }
    return b;
};

//子表的sum方法
function sum(sub_field_code_values){
    var ret_val=0;
    if(!sub_field_code_values || sub_field_code_values.length == 0) return "";
    for(var i=0;i < sub_field_code_values.length;i++){
        if(sub_field_code_values[i]==undefined||sub_field_code_values[i]==""){
            sub_field_code_values[i]=0;
        }
        if(isNaN(sub_field_code_values[i])){
            throw new Error("sum(): 数据内容必须全为数字");
        }
        ret_val += sub_field_code_values[i].toString().to_float();
    }
    return ret_val;
}

//子表的average方法
function average(sub_field_code_values){
    if(!sub_field_code_values || sub_field_code_values.length == 0) return "";
    return sum(sub_field_code_values)/count(sub_field_code_values);
}

//计算数量
function  count(sub_field_code_values){
    if(!sub_field_code_values || sub_field_code_values.length == 0) return "";
    return sub_field_code_values.length;
}

function sortNumber(a,b){
    return  a - b;
}

//子表的max方法
function max(sub_field_code_values){
    if(!sub_field_code_values || sub_field_code_values.length == 0) return "";
    //检查数组的每个元素必须为数字
    for(var i=0;i < sub_field_code_values.length;i++){
        if(isNaN(sub_field_code_values[i])){
            throw new Error("max(): 数据内容必须全为数字");
        }else{
            sub_field_code_values[i] = sub_field_code_values[i].toString() .to_float();
        }
    }
    if(sub_field_code_values.length > 0){
        return sub_field_code_values.sort(sortNumber)[count(sub_field_code_values) - 1];
    }
}

//子表的min方法
function min(sub_field_code_values){
    if(!sub_field_code_values || sub_field_code_values.length == 0) return "";
     //检查数组的每个元素必须为数字
    for(var i=0;i < sub_field_code_values.length;i++){
        if(isNaN(sub_field_code_values[i])){
            throw new Error("min(): 数据内容必须全为数字");
        }else{
            sub_field_code_values[i] = sub_field_code_values[i] .toString().to_float();
        }
    }
    if(sub_field_code_values.length > 0){
        return sub_field_code_values.sort(sortNumber)[0];
    }
}
