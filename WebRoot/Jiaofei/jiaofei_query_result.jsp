<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jiaofei.css" /> 

<div id="jiaofei_manage"></div>
<div id="jiaofei_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="jiaofei_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="jiaofei_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="jiaofei_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="jiaofei_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="jiaofei_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="jiaofeiQueryForm" method="post">
			缴费类型：<input class="textbox" type="text" id="jiaofeiTypeObj_typeId_query" name="jiaofeiTypeObj.typeId" style="width: auto"/>
			缴费名称：<input type="text" class="textbox" id="jiaofeiName" name="jiaofeiName" style="width:110px" />
			缴费学员：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			缴费时间：<input type="text" id="jiaofeiTime" name="jiaofeiTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="jiaofei_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="jiaofeiEditDiv">
	<form id="jiaofeiEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">缴费id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiId_edit" name="jiaofei.jiaofeiId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">缴费类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="jiaofei_jiaofeiTypeObj_typeId_edit" name="jiaofei.jiaofeiTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">缴费名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiName_edit" name="jiaofei.jiaofeiName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">缴费金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiMoney_edit" name="jiaofei.jiaofeiMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">缴费学员:</span>
			<span class="inputControl">
				<input class="textbox"  id="jiaofei_userObj_user_name_edit" name="jiaofei.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">缴费时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiTime_edit" name="jiaofei.jiaofeiTime" />

			</span>

		</div>
		<div>
			<span class="label">缴费备注:</span>
			<span class="inputControl">
				<textarea id="jiaofei_jiaofeiMemo_edit" name="jiaofei.jiaofeiMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Jiaofei/js/jiaofei_manage.js"></script> 
