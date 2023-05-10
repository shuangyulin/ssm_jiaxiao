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
import com.chengxusheji.service.ExamService;
import com.chengxusheji.po.Exam;
import com.chengxusheji.service.CoachService;
import com.chengxusheji.po.Coach;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Exam管理控制层
@Controller
@RequestMapping("/Exam")
public class ExamController extends BaseController {

    /*业务层对象*/
    @Resource ExamService examService;

    @Resource CoachService coachService;
    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("coachObj")
	public void initBindercoachObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("coachObj.");
	}
	@InitBinder("exam")
	public void initBinderExam(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("exam.");
	}
	/*跳转到添加Exam视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Exam());
		/*查询所有的Coach信息*/
		List<Coach> coachList = coachService.queryAllCoach();
		request.setAttribute("coachList", coachList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Exam_add";
	}

	/*客户端ajax方式提交添加考试信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Exam exam, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        examService.addExam(exam);
        message = "考试添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询考试信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String examName,String kemu,@ModelAttribute("userObj") UserInfo userObj,String examDate,String examPlace,@ModelAttribute("coachObj") Coach coachObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (examName == null) examName = "";
		if (kemu == null) kemu = "";
		if (examDate == null) examDate = "";
		if (examPlace == null) examPlace = "";
		if(rows != 0)examService.setRows(rows);
		List<Exam> examList = examService.queryExam(examName, kemu, userObj, examDate, examPlace, coachObj, page);
	    /*计算总的页数和总的记录数*/
	    examService.queryTotalPageAndRecordNumber(examName, kemu, userObj, examDate, examPlace, coachObj);
	    /*获取到总的页码数目*/
	    int totalPage = examService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = examService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Exam exam:examList) {
			JSONObject jsonExam = exam.getJsonObject();
			jsonArray.put(jsonExam);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询考试信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Exam> examList = examService.queryAllExam();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Exam exam:examList) {
			JSONObject jsonExam = new JSONObject();
			jsonExam.accumulate("examId", exam.getExamId());
			jsonExam.accumulate("examName", exam.getExamName());
			jsonArray.put(jsonExam);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询考试信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String examName,String kemu,@ModelAttribute("userObj") UserInfo userObj,String examDate,String examPlace,@ModelAttribute("coachObj") Coach coachObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (examName == null) examName = "";
		if (kemu == null) kemu = "";
		if (examDate == null) examDate = "";
		if (examPlace == null) examPlace = "";
		List<Exam> examList = examService.queryExam(examName, kemu, userObj, examDate, examPlace, coachObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    examService.queryTotalPageAndRecordNumber(examName, kemu, userObj, examDate, examPlace, coachObj);
	    /*获取到总的页码数目*/
	    int totalPage = examService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = examService.getRecordNumber();
	    request.setAttribute("examList",  examList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("examName", examName);
	    request.setAttribute("kemu", kemu);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("examDate", examDate);
	    request.setAttribute("examPlace", examPlace);
	    request.setAttribute("coachObj", coachObj);
	    List<Coach> coachList = coachService.queryAllCoach();
	    request.setAttribute("coachList", coachList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Exam/exam_frontquery_result"; 
	}

     /*前台查询Exam信息*/
	@RequestMapping(value="/{examId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer examId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键examId获取Exam对象*/
        Exam exam = examService.getExam(examId);

        List<Coach> coachList = coachService.queryAllCoach();
        request.setAttribute("coachList", coachList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("exam",  exam);
        return "Exam/exam_frontshow";
	}

	/*ajax方式显示考试修改jsp视图页*/
	@RequestMapping(value="/{examId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer examId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键examId获取Exam对象*/
        Exam exam = examService.getExam(examId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonExam = exam.getJsonObject();
		out.println(jsonExam.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新考试信息*/
	@RequestMapping(value = "/{examId}/update", method = RequestMethod.POST)
	public void update(@Validated Exam exam, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			examService.updateExam(exam);
			message = "考试更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "考试更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除考试信息*/
	@RequestMapping(value="/{examId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer examId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  examService.deleteExam(examId);
	            request.setAttribute("message", "考试删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "考试删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条考试记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String examIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = examService.deleteExams(examIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出考试信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String examName,String kemu,@ModelAttribute("userObj") UserInfo userObj,String examDate,String examPlace,@ModelAttribute("coachObj") Coach coachObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(examName == null) examName = "";
        if(kemu == null) kemu = "";
        if(examDate == null) examDate = "";
        if(examPlace == null) examPlace = "";
        List<Exam> examList = examService.queryExam(examName,kemu,userObj,examDate,examPlace,coachObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Exam信息记录"; 
        String[] headers = { "考试id","考试名称","考试科目","考试学员","考试日期","考试开始时间","考试地点","教练"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<examList.size();i++) {
        	Exam exam = examList.get(i); 
        	dataset.add(new String[]{exam.getExamId() + "",exam.getExamName(),exam.getKemu(),exam.getUserObj().getName(),exam.getExamDate(),exam.getStartTime(),exam.getExamPlace(),exam.getCoachObj().getName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Exam.xls");//filename是下载的xls的名，建议最好用英文 
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
