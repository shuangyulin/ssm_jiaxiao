package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.JiaofeiType;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Jiaofei;

import com.chengxusheji.mapper.JiaofeiMapper;
@Service
public class JiaofeiService {

	@Resource JiaofeiMapper jiaofeiMapper;
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

    /*添加缴费记录*/
    public void addJiaofei(Jiaofei jiaofei) throws Exception {
    	jiaofeiMapper.addJiaofei(jiaofei);
    }

    /*按照查询条件分页查询缴费记录*/
    public ArrayList<Jiaofei> queryJiaofei(JiaofeiType jiaofeiTypeObj,String jiaofeiName,UserInfo userObj,String jiaofeiTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != jiaofeiTypeObj && jiaofeiTypeObj.getTypeId()!= null && jiaofeiTypeObj.getTypeId()!= 0)  where += " and t_jiaofei.jiaofeiTypeObj=" + jiaofeiTypeObj.getTypeId();
    	if(!jiaofeiName.equals("")) where = where + " and t_jiaofei.jiaofeiName like '%" + jiaofeiName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_jiaofei.userObj='" + userObj.getUser_name() + "'";
    	if(!jiaofeiTime.equals("")) where = where + " and t_jiaofei.jiaofeiTime like '%" + jiaofeiTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return jiaofeiMapper.queryJiaofei(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Jiaofei> queryJiaofei(JiaofeiType jiaofeiTypeObj,String jiaofeiName,UserInfo userObj,String jiaofeiTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != jiaofeiTypeObj && jiaofeiTypeObj.getTypeId()!= null && jiaofeiTypeObj.getTypeId()!= 0)  where += " and t_jiaofei.jiaofeiTypeObj=" + jiaofeiTypeObj.getTypeId();
    	if(!jiaofeiName.equals("")) where = where + " and t_jiaofei.jiaofeiName like '%" + jiaofeiName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_jiaofei.userObj='" + userObj.getUser_name() + "'";
    	if(!jiaofeiTime.equals("")) where = where + " and t_jiaofei.jiaofeiTime like '%" + jiaofeiTime + "%'";
    	return jiaofeiMapper.queryJiaofeiList(where);
    }

    /*查询所有缴费记录*/
    public ArrayList<Jiaofei> queryAllJiaofei()  throws Exception {
        return jiaofeiMapper.queryJiaofeiList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(JiaofeiType jiaofeiTypeObj,String jiaofeiName,UserInfo userObj,String jiaofeiTime) throws Exception {
     	String where = "where 1=1";
    	if(null != jiaofeiTypeObj && jiaofeiTypeObj.getTypeId()!= null && jiaofeiTypeObj.getTypeId()!= 0)  where += " and t_jiaofei.jiaofeiTypeObj=" + jiaofeiTypeObj.getTypeId();
    	if(!jiaofeiName.equals("")) where = where + " and t_jiaofei.jiaofeiName like '%" + jiaofeiName + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_jiaofei.userObj='" + userObj.getUser_name() + "'";
    	if(!jiaofeiTime.equals("")) where = where + " and t_jiaofei.jiaofeiTime like '%" + jiaofeiTime + "%'";
        recordNumber = jiaofeiMapper.queryJiaofeiCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取缴费记录*/
    public Jiaofei getJiaofei(int jiaofeiId) throws Exception  {
        Jiaofei jiaofei = jiaofeiMapper.getJiaofei(jiaofeiId);
        return jiaofei;
    }

    /*更新缴费记录*/
    public void updateJiaofei(Jiaofei jiaofei) throws Exception {
        jiaofeiMapper.updateJiaofei(jiaofei);
    }

    /*删除一条缴费记录*/
    public void deleteJiaofei (int jiaofeiId) throws Exception {
        jiaofeiMapper.deleteJiaofei(jiaofeiId);
    }

    /*删除多条缴费信息*/
    public int deleteJiaofeis (String jiaofeiIds) throws Exception {
    	String _jiaofeiIds[] = jiaofeiIds.split(",");
    	for(String _jiaofeiId: _jiaofeiIds) {
    		jiaofeiMapper.deleteJiaofei(Integer.parseInt(_jiaofeiId));
    	}
    	return _jiaofeiIds.length;
    }
}
