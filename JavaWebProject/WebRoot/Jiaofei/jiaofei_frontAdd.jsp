<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.JiaofeiType" %>
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
<title>缴费添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Jiaofei/frontlist">缴费列表</a></li>
			    	<li role="presentation" class="active"><a href="#jiaofeiAdd" aria-controls="jiaofeiAdd" role="tab" data-toggle="tab">添加缴费</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="jiaofeiList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="jiaofeiAdd"> 
				      	<form class="form-horizontal" name="jiaofeiAddForm" id="jiaofeiAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="jiaofei_jiaofeiTypeObj_typeId" class="col-md-2 text-right">缴费类型:</label>
						  	 <div class="col-md-8">
							    <select id="jiaofei_jiaofeiTypeObj_typeId" name="jiaofei.jiaofeiTypeObj.typeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jiaofei_jiaofeiName" class="col-md-2 text-right">缴费名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jiaofei_jiaofeiName" name="jiaofei.jiaofeiName" class="form-control" placeholder="请输入缴费名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jiaofei_jiaofeiMoney" class="col-md-2 text-right">缴费金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="jiaofei_jiaofeiMoney" name="jiaofei.jiaofeiMoney" class="form-control" placeholder="请输入缴费金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jiaofei_userObj_user_name" class="col-md-2 text-right">缴费学员:</label>
						  	 <div class="col-md-8">
							    <select id="jiaofei_userObj_user_name" name="jiaofei.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jiaofei_jiaofeiTimeDiv" class="col-md-2 text-right">缴费时间:</label>
						  	 <div class="col-md-8">
				                <div id="jiaofei_jiaofeiTimeDiv" class="input-group date jiaofei_jiaofeiTime col-md-12" data-link-field="jiaofei_jiaofeiTime">
				                    <input class="form-control" id="jiaofei_jiaofeiTime" name="jiaofei.jiaofeiTime" size="16" type="text" value="" placeholder="请选择缴费时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="jiaofei_jiaofeiMemo" class="col-md-2 text-right">缴费备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="jiaofei_jiaofeiMemo" name="jiaofei.jiaofeiMemo" rows="8" class="form-control" placeholder="请输入缴费备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxJiaofeiAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#jiaofeiAddForm .form-group {margin:10px;}  </style>
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
	//提交添加缴费信息
	function ajaxJiaofeiAdd() { 
		//提交之前先验证表单
		$("#jiaofeiAddForm").data('bootstrapValidator').validate();
		if(!$("#jiaofeiAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Jiaofei/add",
			dataType : "json" , 
			data: new FormData($("#jiaofeiAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#jiaofeiAddForm").find("input").val("");
					$("#jiaofeiAddForm").find("textarea").val("");
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
	//验证缴费添加表单字段
	$('#jiaofeiAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"jiaofei.jiaofeiName": {
				validators: {
					notEmpty: {
						message: "缴费名称不能为空",
					}
				}
			},
			"jiaofei.jiaofeiMoney": {
				validators: {
					notEmpty: {
						message: "缴费金额不能为空",
					},
					numeric: {
						message: "缴费金额不正确"
					}
				}
			},
			"jiaofei.jiaofeiTime": {
				validators: {
					notEmpty: {
						message: "缴费时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化缴费类型下拉框值 
	$.ajax({
		url: basePath + "JiaofeiType/listAll",
		type: "get",
		success: function(jiaofeiTypes,response,status) { 
			$("#jiaofei_jiaofeiTypeObj_typeId").empty();
			var html="";
    		$(jiaofeiTypes).each(function(i,jiaofeiType){
    			html += "<option value='" + jiaofeiType.typeId + "'>" + jiaofeiType.typeName + "</option>";
    		});
    		$("#jiaofei_jiaofeiTypeObj_typeId").html(html);
    	}
	});
	//初始化缴费学员下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#jiaofei_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#jiaofei_userObj_user_name").html(html);
    	}
	});
	//缴费时间组件
	$('#jiaofei_jiaofeiTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#jiaofeiAddForm').data('bootstrapValidator').updateStatus('jiaofei.jiaofeiTime', 'NOT_VALIDATED',null).validateField('jiaofei.jiaofeiTime');
	});
})
</script>
</body>
</html>
