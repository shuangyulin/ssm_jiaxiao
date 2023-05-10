package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Exam;

public interface ExamMapper {
	/*添加考试信息*/
	public void addExam(Exam exam) throws Exception;

	/*按照查询条件分页查询考试记录*/
	public ArrayList<Exam> queryExam(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有考试记录*/
	public ArrayList<Exam> queryExamList(@Param("where") String where) throws Exception;

	/*按照查询条件的考试记录数*/
	public int queryExamCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条考试记录*/
	public Exam getExam(int examId) throws Exception;

	/*更新考试记录*/
	public void updateExam(Exam exam) throws Exception;

	/*删除考试记录*/
	public void deleteExam(int examId) throws Exception;

}
