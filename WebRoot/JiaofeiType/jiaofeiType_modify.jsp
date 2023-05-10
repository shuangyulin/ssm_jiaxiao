<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jiaofeiType.css" />
<div id="jiaofeiType_editDiv">
	<form id="jiaofeiTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofeiType_typeId_edit" name="jiaofeiType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofeiType_typeName_edit" name="jiaofeiType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="jiaofeiTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/JiaofeiType/js/jiaofeiType_modify.js"></script> 
