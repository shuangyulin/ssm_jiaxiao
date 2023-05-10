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
import com.chengxusheji.service.CoachService;
import com.chengxusheji.po.Coach;

//Coach管理控制层
@Controller
@RequestMapping("/Coach")
public class CoachController extends BaseController {

    /*业务层对象*/
    @Resource CoachService coachService;

	@InitBinder("coach")
	public void initBinderCoach(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("coach.");
	}
	/*跳转到添加Coach视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Coach());
		return "Coach_add";
	}

	/*客户端ajax方式提交添加教练信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Coach coach, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(coachService.getCoach(coach.getCoachNo()) != null) {
			message = "教练工号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			coach.setCoachPhoto(this.handlePhotoUpload(request, "coachPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        coachService.addCoach(coach);
        message = "教练添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询教练信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String coachNo,String name,String birthDate,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (coachNo == null) coachNo = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if(rows != 0)coachService.setRows(rows);
		List<Coach> coachList = coachService.queryCoach(coachNo, name, birthDate, telephone, page);
	    /*计算总的页数和总的记录数*/
	    coachService.queryTotalPageAndRecordNumber(coachNo, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = coachService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = coachService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Coach coach:coachList) {
			JSONObject jsonCoach = coach.getJsonObject();
			jsonArray.put(jsonCoach);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询教练信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Coach> coachList = coachService.queryAllCoach();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Coach coach:coachList) {
			JSONObject jsonCoach = new JSONObject();
			jsonCoach.accumulate("coachNo", coach.getCoachNo());
			jsonCoach.accumulate("name", coach.getName());
			jsonArray.put(jsonCoach);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询教练信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String coachNo,String name,String birthDate,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (coachNo == null) coachNo = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		List<Coach> coachList = coachService.queryCoach(coachNo, name, birthDate, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    coachService.queryTotalPageAndRecordNumber(coachNo, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = coachService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = coachService.getRecordNumber();
	    request.setAttribute("coachList",  coachList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("coachNo", coachNo);
	    request.setAttribute("name", name);
	    request.setAttribute("birthDate", birthDate);
	    request.setAttribute("telephone", telephone);
		return "Coach/coach_frontquery_result"; 
	}

     /*前台查询Coach信息*/
	@RequestMapping(value="/{coachNo}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String coachNo,Model model,HttpServletRequest request) throws Exception {
		/*根据主键coachNo获取Coach对象*/
        Coach coach = coachService.getCoach(coachNo);

        request.setAttribute("coach",  coach);
        return "Coach/coach_frontshow";
	}

	/*ajax方式显示教练修改jsp视图页*/
	@RequestMapping(value="/{coachNo}/update",method=RequestMethod.GET)
	public void update(@PathVariable String coachNo,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键coachNo获取Coach对象*/
        Coach coach = coachService.getCoach(coachNo);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCoach = coach.getJsonObject();
		out.println(jsonCoach.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新教练信息*/
	@RequestMapping(value = "/{coachNo}/update", method = RequestMethod.POST)
	public void update(@Validated Coach coach, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String coachPhotoFileName = this.handlePhotoUpload(request, "coachPhotoFile");
		if(!coachPhotoFileName.equals("upload/NoImage.jpg"))coach.setCoachPhoto(coachPhotoFileName); 


		try {
			coachService.updateCoach(coach);
			message = "教练更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "教练更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除教练信息*/
	@RequestMapping(value="/{coachNo}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String coachNo,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  coachService.deleteCoach(coachNo);
	            request.setAttribute("message", "教练删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "教练删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条教练记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String coachNos,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = coachService.deleteCoachs(coachNos);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出教练信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String coachNo,String name,String birthDate,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(coachNo == null) coachNo = "";
        if(name == null) name = "";
        if(birthDate == null) birthDate = "";
        if(telephone == null) telephone = "";
        List<Coach> coachList = coachService.queryCoach(coachNo,name,birthDate,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Coach信息记录"; 
        String[] headers = { "教练工号","姓名","性别","出生日期","教练照片","工作经验","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<coachList.size();i++) {
        	Coach coach = coachList.get(i); 
        	dataset.add(new String[]{coach.getCoachNo(),coach.getName(),coach.getGender(),coach.getBirthDate(),coach.getCoachPhoto(),coach.getWorkYears(),coach.getTelephone()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Coach.xls");//filename是下载的xls的名，建议最好用英文 
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
