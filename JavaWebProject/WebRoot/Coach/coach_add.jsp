<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/coach.css" />
<div id="coachAddDiv">
	<form id="coachAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">教练工号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_coachNo" name="coach.coachNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_name" name="coach.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_gender" name="coach.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_birthDate" name="coach.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">教练照片:</span>
			<span class="inputControl">
				<input id="coachPhotoFile" name="coachPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">工作经验:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_workYears" name="coach.workYears" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_telephone" name="coach.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_address" name="coach.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">教练介绍:</span>
			<span class="inputControl">
				<script name="coach.coachDesc" id="coach_coachDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div class="operation">
			<a id="coachAddButton" class="easyui-linkbutton">添加</a>
			<a id="coachClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Coach/js/coach_add.js"></script> 
