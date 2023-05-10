package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Jiaofei {
    /*缴费id*/
    private Integer jiaofeiId;
    public Integer getJiaofeiId(){
        return jiaofeiId;
    }
    public void setJiaofeiId(Integer jiaofeiId){
        this.jiaofeiId = jiaofeiId;
    }

    /*缴费类型*/
    private JiaofeiType jiaofeiTypeObj;
    public JiaofeiType getJiaofeiTypeObj() {
        return jiaofeiTypeObj;
    }
    public void setJiaofeiTypeObj(JiaofeiType jiaofeiTypeObj) {
        this.jiaofeiTypeObj = jiaofeiTypeObj;
    }

    /*缴费名称*/
    @NotEmpty(message="缴费名称不能为空")
    private String jiaofeiName;
    public String getJiaofeiName() {
        return jiaofeiName;
    }
    public void setJiaofeiName(String jiaofeiName) {
        this.jiaofeiName = jiaofeiName;
    }

    /*缴费金额*/
    @NotNull(message="必须输入缴费金额")
    private Float jiaofeiMoney;
    public Float getJiaofeiMoney() {
        return jiaofeiMoney;
    }
    public void setJiaofeiMoney(Float jiaofeiMoney) {
        this.jiaofeiMoney = jiaofeiMoney;
    }

    /*缴费学员*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*缴费时间*/
    @NotEmpty(message="缴费时间不能为空")
    private String jiaofeiTime;
    public String getJiaofeiTime() {
        return jiaofeiTime;
    }
    public void setJiaofeiTime(String jiaofeiTime) {
        this.jiaofeiTime = jiaofeiTime;
    }

    /*缴费备注*/
    private String jiaofeiMemo;
    public String getJiaofeiMemo() {
        return jiaofeiMemo;
    }
    public void setJiaofeiMemo(String jiaofeiMemo) {
        this.jiaofeiMemo = jiaofeiMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonJiaofei=new JSONObject(); 
		jsonJiaofei.accumulate("jiaofeiId", this.getJiaofeiId());
		jsonJiaofei.accumulate("jiaofeiTypeObj", this.getJiaofeiTypeObj().getTypeName());
		jsonJiaofei.accumulate("jiaofeiTypeObjPri", this.getJiaofeiTypeObj().getTypeId());
		jsonJiaofei.accumulate("jiaofeiName", this.getJiaofeiName());
		jsonJiaofei.accumulate("jiaofeiMoney", this.getJiaofeiMoney());
		jsonJiaofei.accumulate("userObj", this.getUserObj().getName());
		jsonJiaofei.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonJiaofei.accumulate("jiaofeiTime", this.getJiaofeiTime().length()>19?this.getJiaofeiTime().substring(0,19):this.getJiaofeiTime());
		jsonJiaofei.accumulate("jiaofeiMemo", this.getJiaofeiMemo());
		return jsonJiaofei;
    }}