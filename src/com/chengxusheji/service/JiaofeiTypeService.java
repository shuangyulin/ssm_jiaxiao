package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.JiaofeiType;

import com.chengxusheji.mapper.JiaofeiTypeMapper;
@Service
public class JiaofeiTypeService {

	@Resource JiaofeiTypeMapper jiaofeiTypeMapper;
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

    /*添加缴费类型记录*/
    public void addJiaofeiType(JiaofeiType jiaofeiType) throws Exception {
    	jiaofeiTypeMapper.addJiaofeiType(jiaofeiType);
    }

    /*按照查询条件分页查询缴费类型记录*/
    public ArrayList<JiaofeiType> queryJiaofeiType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return jiaofeiTypeMapper.queryJiaofeiType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<JiaofeiType> queryJiaofeiType() throws Exception  { 
     	String where = "where 1=1";
    	return jiaofeiTypeMapper.queryJiaofeiTypeList(where);
    }

    /*查询所有缴费类型记录*/
    public ArrayList<JiaofeiType> queryAllJiaofeiType()  throws Exception {
        return jiaofeiTypeMapper.queryJiaofeiTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = jiaofeiTypeMapper.queryJiaofeiTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取缴费类型记录*/
    public JiaofeiType getJiaofeiType(int typeId) throws Exception  {
        JiaofeiType jiaofeiType = jiaofeiTypeMapper.getJiaofeiType(typeId);
        return jiaofeiType;
    }

    /*更新缴费类型记录*/
    public void updateJiaofeiType(JiaofeiType jiaofeiType) throws Exception {
        jiaofeiTypeMapper.updateJiaofeiType(jiaofeiType);
    }

    /*删除一条缴费类型记录*/
    public void deleteJiaofeiType (int typeId) throws Exception {
        jiaofeiTypeMapper.deleteJiaofeiType(typeId);
    }

    /*删除多条缴费类型信息*/
    public int deleteJiaofeiTypes (String typeIds) throws Exception {
    	String _typeIds[] = typeIds.split(",");
    	for(String _typeId: _typeIds) {
    		jiaofeiTypeMapper.deleteJiaofeiType(Integer.parseInt(_typeId));
    	}
    	return _typeIds.length;
    }
}
