package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Coach {
    /*教练工号*/
    @NotEmpty(message="教练工号不能为空")
    private String coachNo;
    public String getCoachNo(){
        return coachNo;
    }
    public void setCoachNo(String coachNo){
        this.coachNo = coachNo;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String gender;
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*教练照片*/
    private String coachPhoto;
    public String getCoachPhoto() {
        return coachPhoto;
    }
    public void setCoachPhoto(String coachPhoto) {
        this.coachPhoto = coachPhoto;
    }

    /*工作经验*/
    @NotEmpty(message="工作经验不能为空")
    private String workYears;
    public String getWorkYears() {
        return workYears;
    }
    public void setWorkYears(String workYears) {
        this.workYears = workYears;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*家庭地址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*教练介绍*/
    @NotEmpty(message="教练介绍不能为空")
    private String coachDesc;
    public String getCoachDesc() {
        return coachDesc;
    }
    public void setCoachDesc(String coachDesc) {
        this.coachDesc = coachDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCoach=new JSONObject(); 
		jsonCoach.accumulate("coachNo", this.getCoachNo());
		jsonCoach.accumulate("name", this.getName());
		jsonCoach.accumulate("gender", this.getGender());
		jsonCoach.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonCoach.accumulate("coachPhoto", this.getCoachPhoto());
		jsonCoach.accumulate("workYears", this.getWorkYears());
		jsonCoach.accumulate("telephone", this.getTelephone());
		jsonCoach.accumulate("address", this.getAddress());
		jsonCoach.accumulate("coachDesc", this.getCoachDesc());
		return jsonCoach;
    }}