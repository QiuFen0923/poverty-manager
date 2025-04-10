package com.example.entity;

import java.io.Serializable;



/**
 * 反馈
*/
public class Feedback extends Account implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Integer id;

    /** 用户id */
    private Integer userId;

    /** 内容 */
    private String content;

    /** 回复内容 */
    private String dealContent;

    /** 反馈时间 */
    private String time;

    /** 处理状态 */
    private String status;

    /** 用户名 */
    private String username;

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
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

    public String getDealContent() {
        return dealContent;
    }

    public void setDealContent(String dealContent) {
        this.dealContent = dealContent;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
       /* LocalDate currentDate = LocalDate.now();
        LocalTime currentTime = LocalTime.now();

        // 定义日期时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        // 格式化日期时间
        String dateTimeString = formatter.format(currentDate.atTime(currentTime));
        this.time = dateTimeString;*/
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
