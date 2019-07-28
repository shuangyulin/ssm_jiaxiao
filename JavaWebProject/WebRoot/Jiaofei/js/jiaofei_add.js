$(function () {
	$("#jiaofei_jiaofeiTypeObj_typeId").combobox({
	    url:'JiaofeiType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#jiaofei_jiaofeiTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#jiaofei_jiaofeiTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#jiaofei_jiaofeiName").validatebox({
		required : true, 
		missingMessage : '请输入缴费名称',
	});

	$("#jiaofei_jiaofeiMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入缴费金额',
		invalidMessage : '缴费金额输入不对',
	});

	$("#jiaofei_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#jiaofei_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#jiaofei_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#jiaofei_jiaofeiTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#jiaofeiAddButton").click(function () {
		//验证表单 
		if(!$("#jiaofeiAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#jiaofeiAddForm").form({
			    url:"Jiaofei/add",
			    onSubmit: function(){
					if($("#jiaofeiAddForm").form("validate"))  { 
	                	$.messager.progress({
							text : "正在提交数据中...",
						}); 
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#jiaofeiAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#jiaofeiAddForm").submit();
		}
	});

	//单击清空按钮
	$("#jiaofeiClearButton").click(function () { 
		$("#jiaofeiAddForm").form("clear"); 
	});
});
