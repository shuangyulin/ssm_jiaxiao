package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Jiaofei;

public interface JiaofeiMapper {
	/*添加缴费信息*/
	public void addJiaofei(Jiaofei jiaofei) throws Exception;

	/*按照查询条件分页查询缴费记录*/
	public ArrayList<Jiaofei> queryJiaofei(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有缴费记录*/
	public ArrayList<Jiaofei> queryJiaofeiList(@Param("where") String where) throws Exception;

	/*按照查询条件的缴费记录数*/
	public int queryJiaofeiCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条缴费记录*/
	public Jiaofei getJiaofei(int jiaofeiId) throws Exception;

	/*更新缴费记录*/
	public void updateJiaofei(Jiaofei jiaofei) throws Exception;

	/*删除缴费记录*/
	public void deleteJiaofei(int jiaofeiId) throws Exception;

}
