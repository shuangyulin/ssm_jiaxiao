var exam_manage_tool = null; 
$(function () { 
	initExamManageTool(); //建立Exam管理对象
	exam_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#exam_manage").datagrid({
		url : 'Exam/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "examId",
		sortOrder : "desc",
		toolbar : "#exam_manage_tool",
		columns : [[
			{
				field : "examId",
				title : "考试id",
				width : 70,
			},
			{
				field : "examName",
				title : "考试名称",
				width : 140,
			},
			{
				field : "kemu",
				title : "考试科目",
				width : 140,
			},
			{
				field : "userObj",
				title : "考试学员",
				width : 140,
			},
			{
				field : "examDate",
				title : "考试日期",
				width : 140,
			},
			{
				field : "startTime",
				title : "考试开始时间",
				width : 140,
			},
			{
				field : "examPlace",
				title : "考试地点",
				width : 140,
			},
			{
				field : "coachObj",
				title : "教练",
				width : 140,
			},
		]],
	});

	$("#examEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#examEditForm").form("validate")) {
					//验证表单 
					if(!$("#examEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#examEditForm").form({
						    url:"Exam/" + $("#exam_examId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#examEditDiv").dialog("close");
			                        exam_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#examEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#examEditDiv").dialog("close");
				$("#examEditForm").form("reset"); 
			},
		}],
	});
});

function initExamManageTool() {
	exam_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Coach/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#coachObj_coachNo_query").combobox({ 
					    valueField:"coachNo",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{coachNo:"",name:"不限制"});
					$("#coachObj_coachNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#exam_manage").datagrid("reload");
		},
		redo : function () {
			$("#exam_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#exam_manage").datagrid("options").queryParams;
			queryParams["examName"] = $("#examName").val();
			queryParams["kemu"] = $("#kemu").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["examDate"] = $("#examDate").datebox("getValue"); 
			queryParams["examPlace"] = $("#examPlace").val();
			queryParams["coachObj.coachNo"] = $("#coachObj_coachNo_query").combobox("getValue");
			$("#exam_manage").datagrid("options").queryParams=queryParams; 
			$("#exam_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#examQueryForm").form({
			    url:"Exam/OutToExcel",
			});
			//提交表单
			$("#examQueryForm").submit();
		},
		remove : function () {
			var rows = $("#exam_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var examIds = [];
						for (var i = 0; i < rows.length; i ++) {
							examIds.push(rows[i].examId);
						}
						$.ajax({
							type : "POST",
							url : "Exam/deletes",
							data : {
								examIds : examIds.join(","),
							},
							beforeSend : function () {
								$("#exam_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#exam_manage").datagrid("loaded");
									$("#exam_manage").datagrid("load");
									$("#exam_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#exam_manage").datagrid("loaded");
									$("#exam_manage").datagrid("load");
									$("#exam_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#exam_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Exam/" + rows[0].examId +  "/update",
					type : "get",
					data : {
						//examId : rows[0].examId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (exam, response, status) {
						$.messager.progress("close");
						if (exam) { 
							$("#examEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
