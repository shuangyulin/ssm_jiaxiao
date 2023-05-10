<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Coach" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>考试添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Exam/frontlist">考试列表</a></li>
			    	<li role="presentation" class="active"><a href="#examAdd" aria-controls="examAdd" role="tab" data-toggle="tab">添加考试</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="examList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="examAdd"> 
				      	<form class="form-horizontal" name="examAddForm" id="examAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="exam_examName" class="col-md-2 text-right">考试名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="exam_examName" name="exam.examName" class="form-control" placeholder="请输入考试名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exam_kemu" class="col-md-2 text-right">考试科目:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="exam_kemu" name="exam.kemu" class="form-control" placeholder="请输入考试科目">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exam_userObj_user_name" class="col-md-2 text-right">考试学员:</label>
						  	 <div class="col-md-8">
							    <select id="exam_userObj_user_name" name="exam.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exam_examDateDiv" class="col-md-2 text-right">考试日期:</label>
						  	 <div class="col-md-8">
				                <div id="exam_examDateDiv" class="input-group date exam_examDate col-md-12" data-link-field="exam_examDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="exam_examDate" name="exam.examDate" size="16" type="text" value="" placeholder="请选择考试日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exam_startTime" class="col-md-2 text-right">考试开始时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="exam_startTime" name="exam.startTime" class="form-control" placeholder="请输入考试开始时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exam_examPlace" class="col-md-2 text-right">考试地点:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="exam_examPlace" name="exam.examPlace" class="form-control" placeholder="请输入考试地点">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exam_coachObj_coachNo" class="col-md-2 text-right">教练:</label>
						  	 <div class="col-md-8">
							    <select id="exam_coachObj_coachNo" name="exam.coachObj.coachNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="exam_examMemo" class="col-md-2 text-right">考试备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="exam_examMemo" name="exam.examMemo" rows="8" class="form-control" placeholder="请输入考试备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxExamAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#examAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加考试信息
	function ajaxExamAdd() { 
		//提交之前先验证表单
		$("#examAddForm").data('bootstrapValidator').validate();
		if(!$("#examAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Exam/add",
			dataType : "json" , 
			data: new FormData($("#examAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#examAddForm").find("input").val("");
					$("#examAddForm").find("textarea").val("");
				} else {
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
	//验证考试添加表单字段
	$('#examAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"exam.examName": {
				validators: {
					notEmpty: {
						message: "考试名称不能为空",
					}
				}
			},
			"exam.kemu": {
				validators: {
					notEmpty: {
						message: "考试科目不能为空",
					}
				}
			},
			"exam.examDate": {
				validators: {
					notEmpty: {
						message: "考试日期不能为空",
					}
				}
			},
			"exam.startTime": {
				validators: {
					notEmpty: {
						message: "考试开始时间不能为空",
					}
				}
			},
			"exam.examPlace": {
				validators: {
					notEmpty: {
						message: "考试地点不能为空",
					}
				}
			},
		}
	}); 
	//初始化考试学员下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#exam_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#exam_userObj_user_name").html(html);
    	}
	});
	//初始化教练下拉框值 
	$.ajax({
		url: basePath + "Coach/listAll",
		type: "get",
		success: function(coachs,response,status) { 
			$("#exam_coachObj_coachNo").empty();
			var html="";
    		$(coachs).each(function(i,coach){
    			html += "<option value='" + coach.coachNo + "'>" + coach.name + "</option>";
    		});
    		$("#exam_coachObj_coachNo").html(html);
    	}
	});
	//考试日期组件
	$('#exam_examDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#examAddForm').data('bootstrapValidator').updateStatus('exam.examDate', 'NOT_VALIDATED',null).validateField('exam.examDate');
	});
})
</script>
</body>
</html>
