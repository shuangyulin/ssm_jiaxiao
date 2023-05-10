package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Exam {
    /*考试id*/
    private Integer examId;
    public Integer getExamId(){
        return examId;
    }
    public void setExamId(Integer examId){
        this.examId = examId;
    }

    /*考试名称*/
    @NotEmpty(message="考试名称不能为空")
    private String examName;
    public String getExamName() {
        return examName;
    }
    public void setExamName(String examName) {
        this.examName = examName;
    }

    /*考试科目*/
    @NotEmpty(message="考试科目不能为空")
    private String kemu;
    public String getKemu() {
        return kemu;
    }
    public void setKemu(String kemu) {
        this.kemu = kemu;
    }

    /*考试学员*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*考试日期*/
    @NotEmpty(message="考试日期不能为空")
    private String examDate;
    public String getExamDate() {
        return examDate;
    }
    public void setExamDate(String examDate) {
        this.examDate = examDate;
    }

    /*考试开始时间*/
    @NotEmpty(message="考试开始时间不能为空")
    private String startTime;
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /*考试地点*/
    @NotEmpty(message="考试地点不能为空")
    private String examPlace;
    public String getExamPlace() {
        return examPlace;
    }
    public void setExamPlace(String examPlace) {
        this.examPlace = examPlace;
    }

    /*教练*/
    private Coach coachObj;
    public Coach getCoachObj() {
        return coachObj;
    }
    public void setCoachObj(Coach coachObj) {
        this.coachObj = coachObj;
    }

    /*考试备注*/
    private String examMemo;
    public String getExamMemo() {
        return examMemo;
    }
    public void setExamMemo(String examMemo) {
        this.examMemo = examMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonExam=new JSONObject(); 
		jsonExam.accumulate("examId", this.getExamId());
		jsonExam.accumulate("examName", this.getExamName());
		jsonExam.accumulate("kemu", this.getKemu());
		jsonExam.accumulate("userObj", this.getUserObj().getName());
		jsonExam.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonExam.accumulate("examDate", this.getExamDate().length()>19?this.getExamDate().substring(0,19):this.getExamDate());
		jsonExam.accumulate("startTime", this.getStartTime());
		jsonExam.accumulate("examPlace", this.getExamPlace());
		jsonExam.accumulate("coachObj", this.getCoachObj().getName());
		jsonExam.accumulate("coachObjPri", this.getCoachObj().getCoachNo());
		jsonExam.accumulate("examMemo", this.getExamMemo());
		return jsonExam;
    }}