$(function () {
	$.ajax({
		url : "Jiaofei/" + $("#jiaofei_jiaofeiId_edit").val() + "/update",
		type : "get",
		data : {
			//jiaofeiId : $("#jiaofei_jiaofeiId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (jiaofei, response, status) {
			$.messager.progress("close");
			if (jiaofei) { 
				$("#jiaofei_jiaofeiId_edit").val(jiaofei.jiaofeiId);
				$("#jiaofei_jiaofeiId_edit").validatebox({
					required : true,
					missingMessage : "请输入缴费id",
					editable: false
				});
				$("#jiaofei_jiaofeiTypeObj_typeId_edit").combobox({
					url:"JiaofeiType/listAll",
					valueField:"typeId",
					textField:"typeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#jiaofei_jiaofeiTypeObj_typeId_edit").combobox("select", jiaofei.jiaofeiTypeObjPri);
						//var data = $("#jiaofei_jiaofeiTypeObj_typeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#jiaofei_jiaofeiTypeObj_typeId_edit").combobox("select", data[0].typeId);
						//}
					}
				});
				$("#jiaofei_jiaofeiName_edit").val(jiaofei.jiaofeiName);
				$("#jiaofei_jiaofeiName_edit").validatebox({
					required : true,
					missingMessage : "请输入缴费名称",
				});
				$("#jiaofei_jiaofeiMoney_edit").val(jiaofei.jiaofeiMoney);
				$("#jiaofei_jiaofeiMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入缴费金额",
					invalidMessage : "缴费金额输入不对",
				});
				$("#jiaofei_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#jiaofei_userObj_user_name_edit").combobox("select", jiaofei.userObjPri);
						//var data = $("#jiaofei_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#jiaofei_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#jiaofei_jiaofeiTime_edit").datetimebox({
					value: jiaofei.jiaofeiTime,
					required: true,
					showSeconds: true,
				});
				$("#jiaofei_jiaofeiMemo_edit").val(jiaofei.jiaofeiMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#jiaofeiModifyButton").click(function(){ 
		if ($("#jiaofeiEditForm").form("validate")) {
			$("#jiaofeiEditForm").form({
			    url:"Jiaofei/" +  $("#jiaofei_jiaofeiId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#jiaofeiEditForm").form("validate"))  {
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
			$("#jiaofeiEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
