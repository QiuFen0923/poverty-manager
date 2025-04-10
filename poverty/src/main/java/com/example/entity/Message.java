package com.example.entity;

import java.io.Serializable;

public class Message implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;

    private String applyname; // 申请人名字

    private String sfz; // 身份证号码

    private String poorstate; // 贫困状态

    private String poorway; // 贫困方式

    private String homemember; // 家庭人数

    private String ethnic; // 民族

    private String poorclass; // 贫困类别

    private String poorreason; // 致贫原因
    private String time; // 创建时间
    private String user; // 创建人

    private String province; // 省份

    private String currentstate; // 审核状态

    private int age;

    private String suggestion;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getApplyname() {
        return applyname;
    }

    public void setApplyname(String applyname) {
        this.applyname = applyname;
    }

    public String getSfz() {
        return sfz;
    }

    public void setSfz(String sfz) {
        this.sfz = sfz;
    }

    public String getPoorstate() {
        return poorstate;
    }

    public void setPoorstate(String poorstate) {
        this.poorstate = poorstate;
    }

    public String getPoorway() {
        return poorway;
    }

    public void setPoorway(String poorway) {
        this.poorway = poorway;
    }

    public String getHomemember() {
        return homemember;
    }

    public void setHomemember(String homemember) {
        this.homemember = homemember;
    }

    public String getEthnic() {
        return ethnic;
    }

    public void setEthnic(String ethnic) {
        this.ethnic = ethnic;
    }

    public String getPoorclass() {
        return poorclass;
    }

    public void setPoorclass(String poorclass) {
        this.poorclass = poorclass;
    }

    public String getPoorreason() {
        return poorreason;
    }

    public void setPoorreason(String poorreason) {
        this.poorreason = poorreason;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getCurrentstate() {
        return currentstate;
    }

    public String getSuggestion() {
        return suggestion;
    }

    public void setSuggestion(String suggestion) {
        this.suggestion = suggestion;
    }

    public void setCurrentstate(String currentstate) {
        this.currentstate = currentstate;
    }
}