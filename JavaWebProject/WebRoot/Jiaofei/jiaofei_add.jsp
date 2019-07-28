<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jiaofei.css" />
<div id="jiaofeiAddDiv">
	<form id="jiaofeiAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">缴费类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiTypeObj_typeId" name="jiaofei.jiaofeiTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">缴费名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiName" name="jiaofei.jiaofeiName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">缴费金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiMoney" name="jiaofei.jiaofeiMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">缴费学员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_userObj_user_name" name="jiaofei.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">缴费时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="jiaofei_jiaofeiTime" name="jiaofei.jiaofeiTime" />

			</span>

		</div>
		<div>
			<span class="label">缴费备注:</span>
			<span class="inputControl">
				<textarea id="jiaofei_jiaofeiMemo" name="jiaofei.jiaofeiMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="jiaofeiAddButton" class="easyui-linkbutton">添加</a>
			<a id="jiaofeiClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Jiaofei/js/jiaofei_add.js"></script> 
