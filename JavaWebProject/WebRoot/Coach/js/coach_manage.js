var coach_manage_tool = null; 
$(function () { 
	initCoachManageTool(); //建立Coach管理对象
	coach_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#coach_manage").datagrid({
		url : 'Coach/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "coachNo",
		sortOrder : "desc",
		toolbar : "#coach_manage_tool",
		columns : [[
			{
				field : "coachNo",
				title : "教练工号",
				width : 140,
			},
			{
				field : "name",
				title : "姓名",
				width : 140,
			},
			{
				field : "gender",
				title : "性别",
				width : 140,
			},
			{
				field : "birthDate",
				title : "出生日期",
				width : 140,
			},
			{
				field : "coachPhoto",
				title : "教练照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "workYears",
				title : "工作经验",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#coachEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#coachEditForm").form("validate")) {
					//验证表单 
					if(!$("#coachEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#coachEditForm").form({
						    url:"Coach/" + $("#coach_coachNo_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#coachEditDiv").dialog("close");
			                        coach_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#coachEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#coachEditDiv").dialog("close");
				$("#coachEditForm").form("reset"); 
			},
		}],
	});
});

function initCoachManageTool() {
	coach_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#coach_manage").datagrid("reload");
		},
		redo : function () {
			$("#coach_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#coach_manage").datagrid("options").queryParams;
			queryParams["coachNo"] = $("#coachNo").val();
			queryParams["name"] = $("#name").val();
			queryParams["birthDate"] = $("#birthDate").datebox("getValue"); 
			queryParams["telephone"] = $("#telephone").val();
			$("#coach_manage").datagrid("options").queryParams=queryParams; 
			$("#coach_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#coachQueryForm").form({
			    url:"Coach/OutToExcel",
			});
			//提交表单
			$("#coachQueryForm").submit();
		},
		remove : function () {
			var rows = $("#coach_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var coachNos = [];
						for (var i = 0; i < rows.length; i ++) {
							coachNos.push(rows[i].coachNo);
						}
						$.ajax({
							type : "POST",
							url : "Coach/deletes",
							data : {
								coachNos : coachNos.join(","),
							},
							beforeSend : function () {
								$("#coach_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#coach_manage").datagrid("loaded");
									$("#coach_manage").datagrid("load");
									$("#coach_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#coach_manage").datagrid("loaded");
									$("#coach_manage").datagrid("load");
									$("#coach_manage").datagrid("unselectAll");
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
			var rows = $("#coach_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Coach/" + rows[0].coachNo +  "/update",
					type : "get",
					data : {
						//coachNo : rows[0].coachNo,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (coach, response, status) {
						$.messager.progress("close");
						if (coach) { 
							$("#coachEditDiv").dialog("open");
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
							coach_coachDesc_editor.setContent(coach.coachDesc, false);
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
