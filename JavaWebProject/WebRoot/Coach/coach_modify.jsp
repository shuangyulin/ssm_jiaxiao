<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/coach.css" />
<div id="coach_editDiv">
	<form id="coachEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">教练工号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="coach_coachNo_edit" name="coach.coachNo" value="<%=request.getParameter("coachNo") %>" style="width:200px" />
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
				<script id="coach_coachDesc_edit" name="coach.coachDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div class="operation">
			<a id="coachModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Coach/js/coach_modify.js"></script> 
