package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Coach;

public interface CoachMapper {
	/*添加教练信息*/
	public void addCoach(Coach coach) throws Exception;

	/*按照查询条件分页查询教练记录*/
	public ArrayList<Coach> queryCoach(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有教练记录*/
	public ArrayList<Coach> queryCoachList(@Param("where") String where) throws Exception;

	/*按照查询条件的教练记录数*/
	public int queryCoachCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条教练记录*/
	public Coach getCoach(String coachNo) throws Exception;

	/*更新教练记录*/
	public void updateCoach(Coach coach) throws Exception;

	/*删除教练记录*/
	public void deleteCoach(String coachNo) throws Exception;

}
