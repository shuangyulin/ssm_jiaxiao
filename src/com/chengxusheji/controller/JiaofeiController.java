package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.JiaofeiService;
import com.chengxusheji.po.Jiaofei;
import com.chengxusheji.service.JiaofeiTypeService;
import com.chengxusheji.po.JiaofeiType;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Jiaofei管理控制层
@Controller
@RequestMapping("/Jiaofei")
public class JiaofeiController extends BaseController {

    /*业务层对象*/
    @Resource JiaofeiService jiaofeiService;

    @Resource JiaofeiTypeService jiaofeiTypeService;
    @Resource UserInfoService userInfoService;
	@InitBinder("jiaofeiTypeObj")
	public void initBinderjiaofeiTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jiaofeiTypeObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("jiaofei")
	public void initBinderJiaofei(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("jiaofei.");
	}
	/*跳转到添加Jiaofei视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Jiaofei());
		/*查询所有的JiaofeiType信息*/
		List<JiaofeiType> jiaofeiTypeList = jiaofeiTypeService.queryAllJiaofeiType();
		request.setAttribute("jiaofeiTypeList", jiaofeiTypeList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Jiaofei_add";
	}

	/*客户端ajax方式提交添加缴费信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Jiaofei jiaofei, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        jiaofeiService.addJiaofei(jiaofei);
        message = "缴费添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询缴费信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("jiaofeiTypeObj") JiaofeiType jiaofeiTypeObj,String jiaofeiName,@ModelAttribute("userObj") UserInfo userObj,String jiaofeiTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (jiaofeiName == null) jiaofeiName = "";
		if (jiaofeiTime == null) jiaofeiTime = "";
		if(rows != 0)jiaofeiService.setRows(rows);
		List<Jiaofei> jiaofeiList = jiaofeiService.queryJiaofei(jiaofeiTypeObj, jiaofeiName, userObj, jiaofeiTime, page);
	    /*计算总的页数和总的记录数*/
	    jiaofeiService.queryTotalPageAndRecordNumber(jiaofeiTypeObj, jiaofeiName, userObj, jiaofeiTime);
	    /*获取到总的页码数目*/
	    int totalPage = jiaofeiService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jiaofeiService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Jiaofei jiaofei:jiaofeiList) {
			JSONObject jsonJiaofei = jiaofei.getJsonObject();
			jsonArray.put(jsonJiaofei);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询缴费信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Jiaofei> jiaofeiList = jiaofeiService.queryAllJiaofei();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Jiaofei jiaofei:jiaofeiList) {
			JSONObject jsonJiaofei = new JSONObject();
			jsonJiaofei.accumulate("jiaofeiId", jiaofei.getJiaofeiId());
			jsonJiaofei.accumulate("jiaofeiName", jiaofei.getJiaofeiName());
			jsonArray.put(jsonJiaofei);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询缴费信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("jiaofeiTypeObj") JiaofeiType jiaofeiTypeObj,String jiaofeiName,@ModelAttribute("userObj") UserInfo userObj,String jiaofeiTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (jiaofeiName == null) jiaofeiName = "";
		if (jiaofeiTime == null) jiaofeiTime = "";
		List<Jiaofei> jiaofeiList = jiaofeiService.queryJiaofei(jiaofeiTypeObj, jiaofeiName, userObj, jiaofeiTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    jiaofeiService.queryTotalPageAndRecordNumber(jiaofeiTypeObj, jiaofeiName, userObj, jiaofeiTime);
	    /*获取到总的页码数目*/
	    int totalPage = jiaofeiService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = jiaofeiService.getRecordNumber();
	    request.setAttribute("jiaofeiList",  jiaofeiList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("jiaofeiTypeObj", jiaofeiTypeObj);
	    request.setAttribute("jiaofeiName", jiaofeiName);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("jiaofeiTime", jiaofeiTime);
	    List<JiaofeiType> jiaofeiTypeList = jiaofeiTypeService.queryAllJiaofeiType();
	    request.setAttribute("jiaofeiTypeList", jiaofeiTypeList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Jiaofei/jiaofei_frontquery_result"; 
	}

     /*前台查询Jiaofei信息*/
	@RequestMapping(value="/{jiaofeiId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer jiaofeiId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键jiaofeiId获取Jiaofei对象*/
        Jiaofei jiaofei = jiaofeiService.getJiaofei(jiaofeiId);

        List<JiaofeiType> jiaofeiTypeList = jiaofeiTypeService.queryAllJiaofeiType();
        request.setAttribute("jiaofeiTypeList", jiaofeiTypeList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("jiaofei",  jiaofei);
        return "Jiaofei/jiaofei_frontshow";
	}

	/*ajax方式显示缴费修改jsp视图页*/
	@RequestMapping(value="/{jiaofeiId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer jiaofeiId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键jiaofeiId获取Jiaofei对象*/
        Jiaofei jiaofei = jiaofeiService.getJiaofei(jiaofeiId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonJiaofei = jiaofei.getJsonObject();
		out.println(jsonJiaofei.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新缴费信息*/
	@RequestMapping(value = "/{jiaofeiId}/update", method = RequestMethod.POST)
	public void update(@Validated Jiaofei jiaofei, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			jiaofeiService.updateJiaofei(jiaofei);
			message = "缴费更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "缴费更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除缴费信息*/
	@RequestMapping(value="/{jiaofeiId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer jiaofeiId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  jiaofeiService.deleteJiaofei(jiaofeiId);
	            request.setAttribute("message", "缴费删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "缴费删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条缴费记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String jiaofeiIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = jiaofeiService.deleteJiaofeis(jiaofeiIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出缴费信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("jiaofeiTypeObj") JiaofeiType jiaofeiTypeObj,String jiaofeiName,@ModelAttribute("userObj") UserInfo userObj,String jiaofeiTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(jiaofeiName == null) jiaofeiName = "";
        if(jiaofeiTime == null) jiaofeiTime = "";
        List<Jiaofei> jiaofeiList = jiaofeiService.queryJiaofei(jiaofeiTypeObj,jiaofeiName,userObj,jiaofeiTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Jiaofei信息记录"; 
        String[] headers = { "缴费id","缴费类型","缴费名称","缴费金额","缴费学员","缴费时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<jiaofeiList.size();i++) {
        	Jiaofei jiaofei = jiaofeiList.get(i); 
        	dataset.add(new String[]{jiaofei.getJiaofeiId() + "",jiaofei.getJiaofeiTypeObj().getTypeName(),jiaofei.getJiaofeiName(),jiaofei.getJiaofeiMoney() + "",jiaofei.getUserObj().getName(),jiaofei.getJiaofeiTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Jiaofei.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
