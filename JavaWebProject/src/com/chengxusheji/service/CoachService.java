package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Coach;

import com.chengxusheji.mapper.CoachMapper;
@Service
public class CoachService {

	@Resource CoachMapper coachMapper;
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

    /*添加教练记录*/
    public void addCoach(Coach coach) throws Exception {
    	coachMapper.addCoach(coach);
    }

    /*按照查询条件分页查询教练记录*/
    public ArrayList<Coach> queryCoach(String coachNo,String name,String birthDate,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!coachNo.equals("")) where = where + " and t_coach.coachNo like '%" + coachNo + "%'";
    	if(!name.equals("")) where = where + " and t_coach.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_coach.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_coach.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return coachMapper.queryCoach(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Coach> queryCoach(String coachNo,String name,String birthDate,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!coachNo.equals("")) where = where + " and t_coach.coachNo like '%" + coachNo + "%'";
    	if(!name.equals("")) where = where + " and t_coach.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_coach.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_coach.telephone like '%" + telephone + "%'";
    	return coachMapper.queryCoachList(where);
    }

    /*查询所有教练记录*/
    public ArrayList<Coach> queryAllCoach()  throws Exception {
        return coachMapper.queryCoachList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String coachNo,String name,String birthDate,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!coachNo.equals("")) where = where + " and t_coach.coachNo like '%" + coachNo + "%'";
    	if(!name.equals("")) where = where + " and t_coach.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_coach.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_coach.telephone like '%" + telephone + "%'";
        recordNumber = coachMapper.queryCoachCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取教练记录*/
    public Coach getCoach(String coachNo) throws Exception  {
        Coach coach = coachMapper.getCoach(coachNo);
        return coach;
    }

    /*更新教练记录*/
    public void updateCoach(Coach coach) throws Exception {
        coachMapper.updateCoach(coach);
    }

    /*删除一条教练记录*/
    public void deleteCoach (String coachNo) throws Exception {
        coachMapper.deleteCoach(coachNo);
    }

    /*删除多条教练信息*/
    public int deleteCoachs (String coachNos) throws Exception {
    	String _coachNos[] = coachNos.split(",");
    	for(String _coachNo: _coachNos) {
    		coachMapper.deleteCoach(_coachNo);
    	}
    	return _coachNos.length;
    }
}
