<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/exam.css" /> 

<div id="exam_manage"></div>
<div id="exam_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="exam_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="exam_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="exam_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="exam_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="exam_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="examQueryForm" method="post">
			考试名称：<input type="text" class="textbox" id="examName" name="examName" style="width:110px" />
			考试科目：<input type="text" class="textbox" id="kemu" name="kemu" style="width:110px" />
			考试学员：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			考试日期：<input type="text" id="examDate" name="examDate" class="easyui-datebox" editable="false" style="width:100px">
			考试地点：<input type="text" class="textbox" id="examPlace" name="examPlace" style="width:110px" />
			教练：<input class="textbox" type="text" id="coachObj_coachNo_query" name="coachObj.coachNo" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="exam_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="examEditDiv">
	<form id="examEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">考试id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_examId_edit" name="exam.examId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">考试名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_examName_edit" name="exam.examName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">考试科目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_kemu_edit" name="exam.kemu" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">考试学员:</span>
			<span class="inputControl">
				<input class="textbox"  id="exam_userObj_user_name_edit" name="exam.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">考试日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_examDate_edit" name="exam.examDate" />

			</span>

		</div>
		<div>
			<span class="label">考试开始时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_startTime_edit" name="exam.startTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">考试地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_examPlace_edit" name="exam.examPlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教练:</span>
			<span class="inputControl">
				<input class="textbox"  id="exam_coachObj_coachNo_edit" name="exam.coachObj.coachNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">考试备注:</span>
			<span class="inputControl">
				<textarea id="exam_examMemo_edit" name="exam.examMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Exam/js/exam_manage.js"></script> 
