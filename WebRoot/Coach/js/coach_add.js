$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('coach_coachDesc');
	var coach_coachDesc_editor = UE.getEditor('coach_coachDesc'); //教练介绍编辑框
	$("#coach_coachNo").validatebox({
		required : true, 
		missingMessage : '请输入教练工号',
	});

	$("#coach_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#coach_gender").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#coach_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#coach_workYears").validatebox({
		required : true, 
		missingMessage : '请输入工作经验',
	});

	$("#coach_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	//单击添加按钮
	$("#coachAddButton").click(function () {
		if(coach_coachDesc_editor.getContent() == "") {
			alert("请输入教练介绍");
			return;
		}
		//验证表单 
		if(!$("#coachAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#coachAddForm").form({
			    url:"Coach/add",
			    onSubmit: function(){
					if($("#coachAddForm").form("validate"))  { 
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
                        $("#coachAddForm").form("clear");
                        coach_coachDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#coachAddForm").submit();
		}
	});

	//单击清空按钮
	$("#coachClearButton").click(function () { 
		$("#coachAddForm").form("clear"); 
	});
});
