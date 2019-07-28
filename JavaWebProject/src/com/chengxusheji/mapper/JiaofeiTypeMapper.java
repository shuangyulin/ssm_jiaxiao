package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.JiaofeiType;

public interface JiaofeiTypeMapper {
	/*添加缴费类型信息*/
	public void addJiaofeiType(JiaofeiType jiaofeiType) throws Exception;

	/*按照查询条件分页查询缴费类型记录*/
	public ArrayList<JiaofeiType> queryJiaofeiType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有缴费类型记录*/
	public ArrayList<JiaofeiType> queryJiaofeiTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的缴费类型记录数*/
	public int queryJiaofeiTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条缴费类型记录*/
	public JiaofeiType getJiaofeiType(int typeId) throws Exception;

	/*更新缴费类型记录*/
	public void updateJiaofeiType(JiaofeiType jiaofeiType) throws Exception;

	/*删除缴费类型记录*/
	public void deleteJiaofeiType(int typeId) throws Exception;

}
