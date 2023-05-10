<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jiaofei.css" />
<div id="jiaofei_editDiv">
	<form id="jiaofeiEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">缴费id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiId_edit" name="jiaofei.jiaofeiId" value="<%=request.getParameter("jiaofeiId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="jiaofeiModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Jiaofei/js/jiaofei_modify.js"></script> 
