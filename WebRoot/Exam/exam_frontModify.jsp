<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Exam" %>
<%@ page import="com.chengxusheji.po.Coach" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的coachObj信息
    List<Coach> coachList = (List<Coach>)request.getAttribute("coachList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Exam exam = (Exam)request.getAttribute("exam");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改考试信息</TITLE>
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
  		<li class="active">考试信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="examEditForm" id="examEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="exam_examId_edit" class="col-md-3 text-right">考试id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="exam_examId_edit" name="exam.examId" class="form-control" placeholder="请输入考试id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="exam_examName_edit" class="col-md-3 text-right">考试名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exam_examName_edit" name="exam.examName" class="form-control" placeholder="请输入考试名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exam_kemu_edit" class="col-md-3 text-right">考试科目:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exam_kemu_edit" name="exam.kemu" class="form-control" placeholder="请输入考试科目">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exam_userObj_user_name_edit" class="col-md-3 text-right">考试学员:</label>
		  	 <div class="col-md-9">
			    <select id="exam_userObj_user_name_edit" name="exam.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exam_examDate_edit" class="col-md-3 text-right">考试日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date exam_examDate_edit col-md-12" data-link-field="exam_examDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="exam_examDate_edit" name="exam.examDate" size="16" type="text" value="" placeholder="请选择考试日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exam_startTime_edit" class="col-md-3 text-right">考试开始时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exam_startTime_edit" name="exam.startTime" class="form-control" placeholder="请输入考试开始时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exam_examPlace_edit" class="col-md-3 text-right">考试地点:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="exam_examPlace_edit" name="exam.examPlace" class="form-control" placeholder="请输入考试地点">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exam_coachObj_coachNo_edit" class="col-md-3 text-right">教练:</label>
		  	 <div class="col-md-9">
			    <select id="exam_coachObj_coachNo_edit" name="exam.coachObj.coachNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="exam_examMemo_edit" class="col-md-3 text-right">考试备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="exam_examMemo_edit" name="exam.examMemo" rows="8" class="form-control" placeholder="请输入考试备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxExamModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#examEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改考试界面并初始化数据*/
function examEdit(examId) {
	$.ajax({
		url :  basePath + "Exam/" + examId + "/update",
		type : "get",
		dataType: "json",
		success : function (exam, response, status) {
			if (exam) {
				$("#exam_examId_edit").val(exam.examId);
				$("#exam_examName_edit").val(exam.examName);
				$("#exam_kemu_edit").val(exam.kemu);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#exam_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#exam_userObj_user_name_edit").html(html);
		        		$("#exam_userObj_user_name_edit").val(exam.userObjPri);
					}
				});
				$("#exam_examDate_edit").val(exam.examDate);
				$("#exam_startTime_edit").val(exam.startTime);
				$("#exam_examPlace_edit").val(exam.examPlace);
				$.ajax({
					url: basePath + "Coach/listAll",
					type: "get",
					success: function(coachs,response,status) { 
						$("#exam_coachObj_coachNo_edit").empty();
						var html="";
		        		$(coachs).each(function(i,coach){
		        			html += "<option value='" + coach.coachNo + "'>" + coach.name + "</option>";
		        		});
		        		$("#exam_coachObj_coachNo_edit").html(html);
		        		$("#exam_coachObj_coachNo_edit").val(exam.coachObjPri);
					}
				});
				$("#exam_examMemo_edit").val(exam.examMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交考试信息表单给服务器端修改*/
function ajaxExamModify() {
	$.ajax({
		url :  basePath + "Exam/" + $("#exam_examId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#examEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#examQueryForm").submit();
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
    /*考试日期组件*/
    $('.exam_examDate_edit').datetimepicker({
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
    examEdit("<%=request.getParameter("examId")%>");
 })
 </script> 
</body>
</html>

