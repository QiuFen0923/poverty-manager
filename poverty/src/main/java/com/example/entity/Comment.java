package com.example.entity;

import java.io.Serializable;

/**
 * 评论
 */
public class Comment extends Account implements Serializable {
    private static final long serialVersionUID = 1L;


    private Integer id;

    private Integer userId;

    /**
     * 公告id
     */
    private Integer noticeId;

    /**
     * 内容
     */
    private String content;

    /**
     * 时间
     */
    private String time;



    private String title;



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

    public Integer getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(Integer noticeId) {
        this.noticeId = noticeId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}
