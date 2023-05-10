$(function () {
	$("#exam_examName").validatebox({
		required : true, 
		missingMessage : '请输入考试名称',
	});

	$("#exam_kemu").validatebox({
		required : true, 
		missingMessage : '请输入考试科目',
	});

	$("#exam_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#exam_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#exam_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#exam_examDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#exam_startTime").validatebox({
		required : true, 
		missingMessage : '请输入考试开始时间',
	});

	$("#exam_examPlace").validatebox({
		required : true, 
		missingMessage : '请输入考试地点',
	});

	$("#exam_coachObj_coachNo").combobox({
	    url:'Coach/listAll',
	    valueField: "coachNo",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#exam_coachObj_coachNo").combobox("getData"); 
            if (data.length > 0) {
                $("#exam_coachObj_coachNo").combobox("select", data[0].coachNo);
            }
        }
	});
	//单击添加按钮
	$("#examAddButton").click(function () {
		//验证表单 
		if(!$("#examAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#examAddForm").form({
			    url:"Exam/add",
			    onSubmit: function(){
					if($("#examAddForm").form("validate"))  { 
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
                        $("#examAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#examAddForm").submit();
		}
	});

	//单击清空按钮
	$("#examClearButton").click(function () { 
		$("#examAddForm").form("clear"); 
	});
});
