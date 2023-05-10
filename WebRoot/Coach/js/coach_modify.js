$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('coach_coachDesc_edit');
	var coach_coachDesc_edit = UE.getEditor('coach_coachDesc_edit'); //教练介绍编辑器
	coach_coachDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Coach/" + $("#coach_coachNo_edit").val() + "/update",
		type : "get",
		data : {
			//coachNo : $("#coach_coachNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (coach, response, status) {
			$.messager.progress("close");
			if (coach) { 
				$("#coach_coachNo_edit").val(coach.coachNo);
				$("#coach_coachNo_edit").validatebox({
					required : true,
					missingMessage : "请输入教练工号",
					editable: false
				});
				$("#coach_name_edit").val(coach.name);
				$("#coach_name_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#coach_gender_edit").val(coach.gender);
				$("#coach_gender_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#coach_birthDate_edit").datebox({
					value: coach.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#coach_coachPhoto").val(coach.coachPhoto);
				$("#coach_coachPhotoImg").attr("src", coach.coachPhoto);
				$("#coach_workYears_edit").val(coach.workYears);
				$("#coach_workYears_edit").validatebox({
					required : true,
					missingMessage : "请输入工作经验",
				});
				$("#coach_telephone_edit").val(coach.telephone);
				$("#coach_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#coach_address_edit").val(coach.address);
				coach_coachDesc_edit.setContent(coach.coachDesc);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#coachModifyButton").click(function(){ 
		if ($("#coachEditForm").form("validate")) {
			$("#coachEditForm").form({
			    url:"Coach/" +  $("#coach_coachNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#coachEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#coachEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
