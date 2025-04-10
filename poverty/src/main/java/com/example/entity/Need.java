package com.example.entity;

import java.io.Serializable;

/**
 * 管理员
*/
public class Need extends Account implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Integer id;

    /** 用户id */
    private Integer userId;

    /** 需求内容 */
    private String content;

    /** 处理状态 */
    private String status;

    /** 提出时间 */
    private String time;

    /** 领导建议 */
    private String opinion;

    /** 评价 */
    private String evaluate;

    /** 基层处理 */
    private String deal;

    /** 用户名 */
    private String userName;

    /** 用户名 */
    private String username;


    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return userName;
    }

    public void setUsername(String userName) {
        this.userName = userName;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    public String getEvaluate() {
        return evaluate;
    }

    public void setEvaluate(String evaluate) {
        this.evaluate = evaluate;
    }

    public String getDeal() {
        return deal;
    }

    public void setDeal(String deal) {
        this.deal = deal;
    }
}
