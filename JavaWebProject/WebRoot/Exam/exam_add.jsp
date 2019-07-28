<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/exam.css" />
<div id="examAddDiv">
	<form id="examAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">考试名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_examName" name="exam.examName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">考试科目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_kemu" name="exam.kemu" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">考试学员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_userObj_user_name" name="exam.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">考试日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_examDate" name="exam.examDate" />

			</span>

		</div>
		<div>
			<span class="label">考试开始时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_startTime" name="exam.startTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">考试地点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_examPlace" name="exam.examPlace" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教练:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="exam_coachObj_coachNo" name="exam.coachObj.coachNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">考试备注:</span>
			<span class="inputControl">
				<textarea id="exam_examMemo" name="exam.examMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="examAddButton" class="easyui-linkbutton">添加</a>
			<a id="examClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Exam/js/exam_add.js"></script> 
