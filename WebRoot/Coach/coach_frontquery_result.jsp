<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Coach" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Coach> coachList = (List<Coach>)request.getAttribute("coachList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String coachNo = (String)request.getAttribute("coachNo"); //教练工号查询关键字
    String name = (String)request.getAttribute("name"); //姓名查询关键字
    String birthDate = (String)request.getAttribute("birthDate"); //出生日期查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>教练查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Coach/frontlist">教练信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Coach/coach_frontAdd.jsp" style="display:none;">添加教练</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<coachList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Coach coach = coachList.get(i); //获取到教练对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Coach/<%=coach.getCoachNo() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=coach.getCoachPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		教练工号:<%=coach.getCoachNo() %>
			     	</div>
			     	<div class="field">
	            		姓名:<%=coach.getName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=coach.getGender() %>
			     	</div>
			     	<div class="field">
	            		出生日期:<%=coach.getBirthDate() %>
			     	</div>
			     	<div class="field">
	            		工作经验:<%=coach.getWorkYears() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=coach.getTelephone() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Coach/<%=coach.getCoachNo() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="coachEdit('<%=coach.getCoachNo() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="coachDelete('<%=coach.getCoachNo() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>教练查询</h1>
		</div>
		<form name="coachQueryForm" id="coachQueryForm" action="<%=basePath %>Coach/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="coachNo">教练工号:</label>
				<input type="text" id="coachNo" name="coachNo" value="<%=coachNo %>" class="form-control" placeholder="请输入教练工号">
			</div>
			<div class="form-group">
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>
			<div class="form-group">
				<label for="birthDate">出生日期:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="请选择出生日期" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="telephone">联系电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系电话">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="coachEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;教练信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="coach.coachDesc" id="coach_coachDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#coachEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCoachModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var coach_coachDesc_edit = UE.getEditor('coach_coachDesc_edit'); //教练介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.coachQueryForm.currentPage.value = currentPage;
    document.coachQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.coachQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.coachQueryForm.currentPage.value = pageValue;
    documentcoachQueryForm.submit();
}

/*弹出修改教练界面并初始化数据*/
function coachEdit(coachNo) {
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
				coach_coachDesc_edit.setContent(coach.coachDesc, false);
				$('#coachEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除教练信息*/
function coachDelete(coachNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Coach/deletes",
			data : {
				coachNos : coachNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#coachQueryForm").submit();
					//location.href= basePath + "Coach/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

