var jiaofeiType_manage_tool = null; 
$(function () { 
	initJiaofeiTypeManageTool(); //建立JiaofeiType管理对象
	jiaofeiType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#jiaofeiType_manage").datagrid({
		url : 'JiaofeiType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "typeId",
		sortOrder : "desc",
		toolbar : "#jiaofeiType_manage_tool",
		columns : [[
			{
				field : "typeId",
				title : "类型id",
				width : 70,
			},
			{
				field : "typeName",
				title : "类型名称",
				width : 140,
			},
		]],
	});

	$("#jiaofeiTypeEditDiv").dialog({
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
				if ($("#jiaofeiTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#jiaofeiTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#jiaofeiTypeEditForm").form({
						    url:"JiaofeiType/" + $("#jiaofeiType_typeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#jiaofeiTypeEditForm").form("validate"))  {
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
			                        $("#jiaofeiTypeEditDiv").dialog("close");
			                        jiaofeiType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#jiaofeiTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#jiaofeiTypeEditDiv").dialog("close");
				$("#jiaofeiTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initJiaofeiTypeManageTool() {
	jiaofeiType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#jiaofeiType_manage").datagrid("reload");
		},
		redo : function () {
			$("#jiaofeiType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#jiaofeiType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#jiaofeiTypeQueryForm").form({
			    url:"JiaofeiType/OutToExcel",
			});
			//提交表单
			$("#jiaofeiTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#jiaofeiType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var typeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							typeIds.push(rows[i].typeId);
						}
						$.ajax({
							type : "POST",
							url : "JiaofeiType/deletes",
							data : {
								typeIds : typeIds.join(","),
							},
							beforeSend : function () {
								$("#jiaofeiType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#jiaofeiType_manage").datagrid("loaded");
									$("#jiaofeiType_manage").datagrid("load");
									$("#jiaofeiType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#jiaofeiType_manage").datagrid("loaded");
									$("#jiaofeiType_manage").datagrid("load");
									$("#jiaofeiType_manage").datagrid("unselectAll");
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
			var rows = $("#jiaofeiType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "JiaofeiType/" + rows[0].typeId +  "/update",
					type : "get",
					data : {
						//typeId : rows[0].typeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (jiaofeiType, response, status) {
						$.messager.progress("close");
						if (jiaofeiType) { 
							$("#jiaofeiTypeEditDiv").dialog("open");
							$("#jiaofeiType_typeId_edit").val(jiaofeiType.typeId);
							$("#jiaofeiType_typeId_edit").validatebox({
								required : true,
								missingMessage : "请输入类型id",
								editable: false
							});
							$("#jiaofeiType_typeName_edit").val(jiaofeiType.typeName);
							$("#jiaofeiType_typeName_edit").validatebox({
								required : true,
								missingMessage : "请输入类型名称",
							});
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
