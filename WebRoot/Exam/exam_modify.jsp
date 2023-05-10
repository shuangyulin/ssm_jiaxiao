<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/exam.css" />
<div id="exam_editDiv">
	<form id="examEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">考试id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_examId_edit" name="exam.examId" value="<%=request.getParameter("examId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="examModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Exam/js/exam_modify.js"></script> 
