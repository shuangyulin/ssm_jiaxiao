var jiaofei_manage_tool = null; 
$(function () { 
	initJiaofeiManageTool(); //建立Jiaofei管理对象
	jiaofei_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#jiaofei_manage").datagrid({
		url : 'Jiaofei/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "jiaofeiId",
		sortOrder : "desc",
		toolbar : "#jiaofei_manage_tool",
		columns : [[
			{
				field : "jiaofeiId",
				title : "缴费id",
				width : 70,
			},
			{
				field : "jiaofeiTypeObj",
				title : "缴费类型",
				width : 140,
			},
			{
				field : "jiaofeiName",
				title : "缴费名称",
				width : 140,
			},
			{
				field : "jiaofeiMoney",
				title : "缴费金额",
				width : 70,
			},
			{
				field : "userObj",
				title : "缴费学员",
				width : 140,
			},
			{
				field : "jiaofeiTime",
				title : "缴费时间",
				width : 140,
			},
		]],
	});

	$("#jiaofeiEditDiv").dialog({
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
				if ($("#jiaofeiEditForm").form("validate")) {
					//验证表单 
					if(!$("#jiaofeiEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#jiaofeiEditForm").form({
						    url:"Jiaofei/" + $("#jiaofei_jiaofeiId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#jiaofeiEditDiv").dialog("close");
			                        jiaofei_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#jiaofeiEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#jiaofeiEditDiv").dialog("close");
				$("#jiaofeiEditForm").form("reset"); 
			},
		}],
	});
});

function initJiaofeiManageTool() {
	jiaofei_manage_tool = {
		init: function() {
			$.ajax({
				url : "JiaofeiType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#jiaofeiTypeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"typeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,typeName:"不限制"});
					$("#jiaofeiTypeObj_typeId_query").combobox("loadData",data); 
				}
			});
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
		},
		reload : function () {
			$("#jiaofei_manage").datagrid("reload");
		},
		redo : function () {
			$("#jiaofei_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#jiaofei_manage").datagrid("options").queryParams;
			queryParams["jiaofeiTypeObj.typeId"] = $("#jiaofeiTypeObj_typeId_query").combobox("getValue");
			queryParams["jiaofeiName"] = $("#jiaofeiName").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["jiaofeiTime"] = $("#jiaofeiTime").datebox("getValue"); 
			$("#jiaofei_manage").datagrid("options").queryParams=queryParams; 
			$("#jiaofei_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#jiaofeiQueryForm").form({
			    url:"Jiaofei/OutToExcel",
			});
			//提交表单
			$("#jiaofeiQueryForm").submit();
		},
		remove : function () {
			var rows = $("#jiaofei_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var jiaofeiIds = [];
						for (var i = 0; i < rows.length; i ++) {
							jiaofeiIds.push(rows[i].jiaofeiId);
						}
						$.ajax({
							type : "POST",
							url : "Jiaofei/deletes",
							data : {
								jiaofeiIds : jiaofeiIds.join(","),
							},
							beforeSend : function () {
								$("#jiaofei_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#jiaofei_manage").datagrid("loaded");
									$("#jiaofei_manage").datagrid("load");
									$("#jiaofei_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#jiaofei_manage").datagrid("loaded");
									$("#jiaofei_manage").datagrid("load");
									$("#jiaofei_manage").datagrid("unselectAll");
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
			var rows = $("#jiaofei_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Jiaofei/" + rows[0].jiaofeiId +  "/update",
					type : "get",
					data : {
						//jiaofeiId : rows[0].jiaofeiId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (jiaofei, response, status) {
						$.messager.progress("close");
						if (jiaofei) { 
							$("#jiaofeiEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
