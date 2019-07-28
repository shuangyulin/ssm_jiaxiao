<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Coach" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Coach coach = (Coach)request.getAttribute("coach");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改教练信息</TITLE>
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
  		<li class="active">教练信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="coachEditForm" id="coachEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="coach_coachNo_edit" class="col-md-3 text-right">教练工号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="coach_coachNo_edit" name="coach.coachNo" class="form-control" placeholder="请输入教练工号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="coach_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="coach_name_edit" name="coach.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="coach_gender_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="coach_gender_edit" name="coach.gender" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="coach_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date coach_birthDate_edit col-md-12" data-link-field="coach_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="coach_birthDate_edit" name="coach.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="coach_coachPhoto_edit" class="col-md-3 text-right">教练照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="coach_coachPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="coach_coachPhoto" name="coach.coachPhoto"/>
			    <input id="coachPhotoFile" name="coachPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="coach_workYears_edit" class="col-md-3 text-right">工作经验:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="coach_workYears_edit" name="coach.workYears" class="form-control" placeholder="请输入工作经验">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="coach_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="coach_telephone_edit" name="coach.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="coach_address_edit" class="col-md-3 text-right">家庭地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="coach_address_edit" name="coach.address" class="form-control" placeholder="请输入家庭地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="coach_coachDesc_edit" class="col-md-3 text-right">教练介绍:</label>
		  	 <div class="col-md-9">
			    <script name="coach.coachDesc" id="coach_coachDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCoachModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#coachEditForm .form-group {margin-bottom:5px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var coach_coachDesc_editor = UE.getEditor('coach_coachDesc_edit'); //教练介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改教练界面并初始化数据*/
function coachEdit(coachNo) {
  coach_coachDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(coachNo);
  });
}
 function ajaxModifyQuery(coachNo) {
	$.ajax({
		url :  basePath + "Coach/" + coachNo + "/update",
		type : "get",
		dataType: "json",
		success : function (coach, response, status) {
			if (coach) {
				$("#coach_coachNo_edit").val(coach.coachNo);
				$("#coach_name_edit").val(coach.name);
				$("#coach_gender_edit").val(coach.gender);
				$("#coach_birthDate_edit").val(coach.birthDate);
				$("#coach_coachPhoto").val(coach.coachPhoto);
				$("#coach_coachPhotoImg").attr("src", basePath +　coach.coachPhoto);
				$("#coach_workYears_edit").val(coach.workYears);
				$("#coach_telephone_edit").val(coach.telephone);
				$("#coach_address_edit").val(coach.address);
				coach_coachDesc_editor.setContent(coach.coachDesc, false);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交教练信息表单给服务器端修改*/
function ajaxCoachModify() {
	$.ajax({
		url :  basePath + "Coach/" + $("#coach_coachNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#coachEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#coachQueryForm").submit();
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
    /*出生日期组件*/
    $('.coach_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    coachEdit("<%=request.getParameter("coachNo")%>");
 })
 </script> 
</body>
</html>

