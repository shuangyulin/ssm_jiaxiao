<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jiaofeiType.css" />
<div id="jiaofeiTypeAddDiv">
	<form id="jiaofeiTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofeiType_typeName" name="jiaofeiType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="jiaofeiTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="jiaofeiTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/JiaofeiType/js/jiaofeiType_add.js"></script> 
