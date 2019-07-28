package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Coach;
import com.chengxusheji.po.Exam;

import com.chengxusheji.mapper.ExamMapper;
@Service
public class ExamService {

	@Resource ExamMapper examMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加考试记录*/
    public void addExam(Exam exam) throws Exception {
    	examMapper.addExam(exam);
    }

    /*按照查询条件分页查询考试记录*/
    public ArrayList<Exam> queryExam(String examName,String kemu,UserInfo userObj,String examDate,String examPlace,Coach coachObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!examName.equals("")) where = where + " and t_exam.examName like '%" + examName + "%'";
    	if(!kemu.equals("")) where = where + " and t_exam.kemu like '%" + kemu + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_exam.userObj='" + userObj.getUser_name() + "'";
    	if(!examDate.equals("")) where = where + " and t_exam.examDate like '%" + examDate + "%'";
    	if(!examPlace.equals("")) where = where + " and t_exam.examPlace like '%" + examPlace + "%'";
    	if(null != coachObj &&  coachObj.getCoachNo() != null  && !coachObj.getCoachNo().equals(""))  where += " and t_exam.coachObj='" + coachObj.getCoachNo() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return examMapper.queryExam(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Exam> queryExam(String examName,String kemu,UserInfo userObj,String examDate,String examPlace,Coach coachObj) throws Exception  { 
     	String where = "where 1=1";
    	if(!examName.equals("")) where = where + " and t_exam.examName like '%" + examName + "%'";
    	if(!kemu.equals("")) where = where + " and t_exam.kemu like '%" + kemu + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_exam.userObj='" + userObj.getUser_name() + "'";
    	if(!examDate.equals("")) where = where + " and t_exam.examDate like '%" + examDate + "%'";
    	if(!examPlace.equals("")) where = where + " and t_exam.examPlace like '%" + examPlace + "%'";
    	if(null != coachObj &&  coachObj.getCoachNo() != null && !coachObj.getCoachNo().equals(""))  where += " and t_exam.coachObj='" + coachObj.getCoachNo() + "'";
    	return examMapper.queryExamList(where);
    }

    /*查询所有考试记录*/
    public ArrayList<Exam> queryAllExam()  throws Exception {
        return examMapper.queryExamList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String examName,String kemu,UserInfo userObj,String examDate,String examPlace,Coach coachObj) throws Exception {
     	String where = "where 1=1";
    	if(!examName.equals("")) where = where + " and t_exam.examName like '%" + examName + "%'";
    	if(!kemu.equals("")) where = where + " and t_exam.kemu like '%" + kemu + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_exam.userObj='" + userObj.getUser_name() + "'";
    	if(!examDate.equals("")) where = where + " and t_exam.examDate like '%" + examDate + "%'";
    	if(!examPlace.equals("")) where = where + " and t_exam.examPlace like '%" + examPlace + "%'";
    	if(null != coachObj &&  coachObj.getCoachNo() != null && !coachObj.getCoachNo().equals(""))  where += " and t_exam.coachObj='" + coachObj.getCoachNo() + "'";
        recordNumber = examMapper.queryExamCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取考试记录*/
    public Exam getExam(int examId) throws Exception  {
        Exam exam = examMapper.getExam(examId);
        return exam;
    }

    /*更新考试记录*/
    public void updateExam(Exam exam) throws Exception {
        examMapper.updateExam(exam);
    }

    /*删除一条考试记录*/
    public void deleteExam (int examId) throws Exception {
        examMapper.deleteExam(examId);
    }

    /*删除多条考试信息*/
    public int deleteExams (String examIds) throws Exception {
    	String _examIds[] = examIds.split(",");
    	for(String _examId: _examIds) {
    		examMapper.deleteExam(Integer.parseInt(_examId));
    	}
    	return _examIds.length;
    }
}
