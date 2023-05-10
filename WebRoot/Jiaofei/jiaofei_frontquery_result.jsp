<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Jiaofei" %>
<%@ page import="com.chengxusheji.po.JiaofeiType" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Jiaofei> jiaofeiList = (List<Jiaofei>)request.getAttribute("jiaofeiList");
    //获取所有的jiaofeiTypeObj信息
    List<JiaofeiType> jiaofeiTypeList = (List<JiaofeiType>)request.getAttribute("jiaofeiTypeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    JiaofeiType jiaofeiTypeObj = (JiaofeiType)request.getAttribute("jiaofeiTypeObj");
    String jiaofeiName = (String)request.getAttribute("jiaofeiName"); //缴费名称查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String jiaofeiTime = (String)request.getAttribute("jiaofeiTime"); //缴费时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>缴费查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#jiaofeiListPanel" aria-controls="jiaofeiListPanel" role="tab" data-toggle="tab">缴费列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Jiaofei/jiaofei_frontAdd.jsp" style="display:none;">添加缴费</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="jiaofeiListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>缴费id</td><td>缴费类型</td><td>缴费名称</td><td>缴费金额</td><td>缴费学员</td><td>缴费时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<jiaofeiList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Jiaofei jiaofei = jiaofeiList.get(i); //获取到缴费对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=jiaofei.getJiaofeiId() %></td>
 											<td><%=jiaofei.getJiaofeiTypeObj().getTypeName() %></td>
 											<td><%=jiaofei.getJiaofeiName() %></td>
 											<td><%=jiaofei.getJiaofeiMoney() %></td>
 											<td><%=jiaofei.getUserObj().getName() %></td>
 											<td><%=jiaofei.getJiaofeiTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Jiaofei/<%=jiaofei.getJiaofeiId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="jiaofeiEdit('<%=jiaofei.getJiaofeiId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="jiaofeiDelete('<%=jiaofei.getJiaofeiId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>缴费查询</h1>
		</div>
		<form name="jiaofeiQueryForm" id="jiaofeiQueryForm" action="<%=basePath %>Jiaofei/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="jiaofeiTypeObj_typeId">缴费类型：</label>
                <select id="jiaofeiTypeObj_typeId" name="jiaofeiTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(JiaofeiType jiaofeiTypeTemp:jiaofeiTypeList) {
	 					String selected = "";
 					if(jiaofeiTypeObj!=null && jiaofeiTypeObj.getTypeId()!=null && jiaofeiTypeObj.getTypeId().intValue()==jiaofeiTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=jiaofeiTypeTemp.getTypeId() %>" <%=selected %>><%=jiaofeiTypeTemp.getTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="jiaofeiName">缴费名称:</label>
				<input type="text" id="jiaofeiName" name="jiaofeiName" value="<%=jiaofeiName %>" class="form-control" placeholder="请输入缴费名称">
			</div>






            <div class="form-group">
            	<label for="userObj_user_name">缴费学员：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="jiaofeiTime">缴费时间:</label>
				<input type="text" id="jiaofeiTime" name="jiaofeiTime" class="form-control"  placeholder="请选择缴费时间" value="<%=jiaofeiTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="jiaofeiEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;缴费信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#jiaofeiEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxJiaofeiModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.jiaofeiQueryForm.currentPage.value = currentPage;
    document.jiaofeiQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.jiaofeiQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.jiaofeiQueryForm.currentPage.value = pageValue;
    documentjiaofeiQueryForm.submit();
}

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
				$('#jiaofeiEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除缴费信息*/
function jiaofeiDelete(jiaofeiId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Jiaofei/deletes",
			data : {
				jiaofeiIds : jiaofeiId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#jiaofeiQueryForm").submit();
					//location.href= basePath + "Jiaofei/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

