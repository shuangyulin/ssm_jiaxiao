<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/coach.css" /> 

<div id="coach_manage"></div>
<div id="coach_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="coach_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="coach_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="coach_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="coach_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="coach_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="coachQueryForm" method="post">
			教练工号：<input type="text" class="textbox" id="coachNo" name="coachNo" style="width:110px" />
			姓名：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			出生日期：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="coach_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="coachEditDiv">
	<form id="coachEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">教练工号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_coachNo_edit" name="coach.coachNo" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_name_edit" name="coach.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_gender_edit" name="coach.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_birthDate_edit" name="coach.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">教练照片:</span>
			<span class="inputControl">
				<img id="coach_coachPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="coach_coachPhoto" name="coach.coachPhoto"/>
				<input id="coachPhotoFile" name="coachPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">工作经验:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_workYears_edit" name="coach.workYears" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_telephone_edit" name="coach.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_address_edit" name="coach.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教练介绍:</span>
			<span class="inputControl">
				<script name="coach.coachDesc" id="coach_coachDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var coach_coachDesc_editor = UE.getEditor('coach_coachDesc_edit'); //教练介绍编辑器
</script>
<script type="text/javascript" src="Coach/js/coach_manage.js"></script> 
