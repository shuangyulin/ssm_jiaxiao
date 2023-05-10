<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Jiaofei" %>
<%@ page import="com.chengxusheji.po.JiaofeiType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的jiaofeiTypeObj信息
    List<JiaofeiType> jiaofeiTypeList = (List<JiaofeiType>)request.getAttribute("jiaofeiTypeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Jiaofei jiaofei = (Jiaofei)request.getAttribute("jiaofei");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改缴费信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">缴费信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="jiaofeiEditForm" id="jiaofeiEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="jiaofei_jiaofeiId_edit" class="col-md-3 text-right">缴费id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="jiaofei_jiaofeiId_edit" name="jiaofei.jiaofeiId" class="form-control" placeholder="请输入缴费id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="jiaofei_jiaofeiTypeObj_typeId_edit" class="col-md-3 text-right">缴费类型:</label>
		  	 <div class="col-md-9">
			    <select id="jiaofei_jiaofeiTypeObj_typeId_edit" name="jiaofei.jiaofeiTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jiaofei_jiaofeiName_edit" class="col-md-3 text-right">缴费名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jiaofei_jiaofeiName_edit" name="jiaofei.jiaofeiName" class="form-control" placeholder="请输入缴费名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jiaofei_jiaofeiMoney_edit" class="col-md-3 text-right">缴费金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="jiaofei_jiaofeiMoney_edit" name="jiaofei.jiaofeiMoney" class="form-control" placeholder="请输入缴费金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jiaofei_userObj_user_name_edit" class="col-md-3 text-right">缴费学员:</label>
		  	 <div class="col-md-9">
			    <select id="jiaofei_userObj_user_name_edit" name="jiaofei.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jiaofei_jiaofeiTime_edit" class="col-md-3 text-right">缴费时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date jiaofei_jiaofeiTime_edit col-md-12" data-link-field="jiaofei_jiaofeiTime_edit">
                    <input class="form-control" id="jiaofei_jiaofeiTime_edit" name="jiaofei.jiaofeiTime" size="16" type="text" value="" placeholder="请选择缴费时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="jiaofei_jiaofeiMemo_edit" class="col-md-3 text-right">缴费备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="jiaofei_jiaofeiMemo_edit" name="jiaofei.jiaofeiMemo" rows="8" class="form-control" placeholder="请输入缴费备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxJiaofeiModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#jiaofeiEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改缴费界面并初始化数据*/
function jiaofeiEdit(jiaofeiId) {
	$.ajax({
		url :  basePath + "Jiaofei/" + jiaofeiId + "/update",
		type : "get",
		dataType: "json",
		success : function (jiaofei, response, status) {
			if (jiaofei) {
				$("#jiaofei_jiaofeiId_edit").val(jiaofei.jiaofeiId);
				$.ajax({
					url: basePath + "JiaofeiType/listAll",
					type: "get",
					success: function(jiaofeiTypes,response,status) { 
						$("#jiaofei_jiaofeiTypeObj_typeId_edit").empty();
						var html="";
		        		$(jiaofeiTypes).each(function(i,jiaofeiType){
		        			html += "<option value='" + jiaofeiType.typeId + "'>" + jiaofeiType.typeName + "</option>";
		        		});
		        		$("#jiaofei_jiaofeiTypeObj_typeId_edit").html(html);
		        		$("#jiaofei_jiaofeiTypeObj_typeId_edit").val(jiaofei.jiaofeiTypeObjPri);
					}
				});
				$("#jiaofei_jiaofeiName_edit").val(jiaofei.jiaofeiName);
				$("#jiaofei_jiaofeiMoney_edit").val(jiaofei.jiaofeiMoney);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#jiaofei_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#jiaofei_userObj_user_name_edit").html(html);
		        		$("#jiaofei_userObj_user_name_edit").val(jiaofei.userObjPri);
					}
				});
				$("#jiaofei_jiaofeiTime_edit").val(jiaofei.jiaofeiTime);
				$("#jiaofei_jiaofeiMemo_edit").val(jiaofei.jiaofeiMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交缴费信息表单给服务器端修改*/
function ajaxJiaofeiModify() {
	$.ajax({
		url :  basePath + "Jiaofei/" + $("#jiaofei_jiaofeiId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#jiaofeiEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#jiaofeiQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*缴费时间组件*/
    $('.jiaofei_jiaofeiTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    jiaofeiEdit("<%=request.getParameter("jiaofeiId")%>");
 })
 </script> 
</body>
</html>

