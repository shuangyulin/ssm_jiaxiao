<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>教练添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Coach/frontlist">教练管理</a></li>
  			<li class="active">添加教练</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="coachAddForm" id="coachAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="coach_coachNo" class="col-md-2 text-right">教练工号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="coach_coachNo" name="coach.coachNo" class="form-control" placeholder="请输入教练工号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="coach_name" class="col-md-2 text-right">姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="coach_name" name="coach.name" class="form-control" placeholder="请输入姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="coach_gender" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="coach_gender" name="coach.gender" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="coach_birthDateDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="coach_birthDateDiv" class="input-group date coach_birthDate col-md-12" data-link-field="coach_birthDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="coach_birthDate" name="coach.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="coach_coachPhoto" class="col-md-2 text-right">教练照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="coach_coachPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="coach_coachPhoto" name="coach.coachPhoto"/>
					    <input id="coachPhotoFile" name="coachPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="coach_workYears" class="col-md-2 text-right">工作经验:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="coach_workYears" name="coach.workYears" class="form-control" placeholder="请输入工作经验">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="coach_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="coach_telephone" name="coach.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="coach_address" class="col-md-2 text-right">家庭地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="coach_address" name="coach.address" class="form-control" placeholder="请输入家庭地址">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="coach_coachDesc" class="col-md-2 text-right">教练介绍:</label>
				  	 <div class="col-md-8">
							    <textarea name="coach.coachDesc" id="coach_coachDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxCoachAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#coachAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var coach_coachDesc_editor = UE.getEditor('coach_coachDesc'); //教练介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加教练信息
	function ajaxCoachAdd() { 
		//提交之前先验证表单
		$("#coachAddForm").data('bootstrapValidator').validate();
		if(!$("#coachAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(coach_coachDesc_editor.getContent() == "") {
			alert('教练介绍不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Coach/add",
			dataType : "json" , 
			data: new FormData($("#coachAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#coachAddForm").find("input").val("");
					$("#coachAddForm").find("textarea").val("");
					coach_coachDesc_editor.setContent("");
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
	//验证教练添加表单字段
	$('#coachAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"coach.coachNo": {
				validators: {
					notEmpty: {
						message: "教练工号不能为空",
					}
				}
			},
			"coach.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"coach.gender": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"coach.birthDate": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
			"coach.workYears": {
				validators: {
					notEmpty: {
						message: "工作经验不能为空",
					}
				}
			},
			"coach.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
		}
	}); 
	//出生日期组件
	$('#coach_birthDateDiv').datetimepicker({
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
		$('#coachAddForm').data('bootstrapValidator').updateStatus('coach.birthDate', 'NOT_VALIDATED',null).validateField('coach.birthDate');
	});
})
</script>
</body>
</html>
