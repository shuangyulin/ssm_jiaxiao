$(function () {
	$.ajax({
		url : "Exam/" + $("#exam_examId_edit").val() + "/update",
		type : "get",
		data : {
			//examId : $("#exam_examId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (exam, response, status) {
			$.messager.progress("close");
			if (exam) { 
				$("#exam_examId_edit").val(exam.examId);
				$("#exam_examId_edit").validatebox({
					required : true,
					missingMessage : "请输入考试id",
					editable: false
				});
				$("#exam_examName_edit").val(exam.examName);
				$("#exam_examName_edit").validatebox({
					required : true,
					missingMessage : "请输入考试名称",
				});
				$("#exam_kemu_edit").val(exam.kemu);
				$("#exam_kemu_edit").validatebox({
					required : true,
					missingMessage : "请输入考试科目",
				});
				$("#exam_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#exam_userObj_user_name_edit").combobox("select", exam.userObjPri);
						//var data = $("#exam_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#exam_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#exam_examDate_edit").datebox({
					value: exam.examDate,
					required: true,
					showSeconds: true,
				});
				$("#exam_startTime_edit").val(exam.startTime);
				$("#exam_startTime_edit").validatebox({
					required : true,
					missingMessage : "请输入考试开始时间",
				});
				$("#exam_examPlace_edit").val(exam.examPlace);
				$("#exam_examPlace_edit").validatebox({
					required : true,
					missingMessage : "请输入考试地点",
				});
				$("#exam_coachObj_coachNo_edit").combobox({
					url:"Coach/listAll",
					valueField:"coachNo",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#exam_coachObj_coachNo_edit").combobox("select", exam.coachObjPri);
						//var data = $("#exam_coachObj_coachNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#exam_coachObj_coachNo_edit").combobox("select", data[0].coachNo);
						//}
					}
				});
				$("#exam_examMemo_edit").val(exam.examMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#examModifyButton").click(function(){ 
		if ($("#examEditForm").form("validate")) {
			$("#examEditForm").form({
			    url:"Exam/" +  $("#exam_examId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#examEditForm").form("validate"))  {
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
			$("#examEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
