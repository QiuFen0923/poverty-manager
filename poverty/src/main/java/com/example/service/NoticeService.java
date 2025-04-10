package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.entity.Account;
import com.example.entity.Notice;
import com.example.mapper.NoticeMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 公告信息表业务处理
 **/
@Service
public class NoticeService {

    @Resource
    private NoticeMapper noticeMapper;

    /**
     * 新增
     */
    public void add(Notice notice) {
        notice.setTime(DateUtil.today());
        Account currentUser = TokenUtils.getCurrentUser();
        notice.setUser(currentUser.getUsername());
        noticeMapper.insert(notice);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        noticeMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            noticeMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Notice notice) {
        noticeMapper.updateById(notice);
    }

    /**
     * 根据ID查询
     */
    public Notice selectById(Integer id) {
        return noticeMapper.selectById(id);
    }

    /**
     * 查询所有公告
     */
    public List<Notice> selectAll(Notice notice) {
        notice.setStatus("公告");
        return noticeMapper.selectAll(notice);
    }

    /**
     * 查询所有资讯
     */
    public List<Notice> selectAll1(Notice notice) {
        notice.setStatus("资讯");
        return noticeMapper.selectAll(notice);
    }


    /**
     * 查询所有政策
     */
    public List<Notice> selectAll2(Notice notice) {
        notice.setStatus("政策");
        return noticeMapper.selectAll(notice);
    }
    /**
     * 分页查询资讯
     */
    public PageInfo<Notice> selectPage(Notice notice, Integer pageNum, Integer pageSize) {
        notice.setStatus("资讯");
        PageHelper.startPage(pageNum, pageSize);
        List<Notice> list = noticeMapper.selectAll(notice);
        return PageInfo.of(list);
    }
    /**
     * 分页查询政策
     */
    public PageInfo<Notice> selectPage2(Notice notice, Integer pageNum, Integer pageSize) {
        notice.setStatus("政策");
        PageHelper.startPage(pageNum, pageSize);
        List<Notice> list = noticeMapper.selectAll(notice);
        return PageInfo.of(list);
    }
    /**
     * 分页查询公告
     */
    public PageInfo<Notice> selectPage3(Notice notice, Integer pageNum, Integer pageSize) {
        notice.setStatus("公告");
        PageHelper.startPage(pageNum, pageSize);
        List<Notice> list = noticeMapper.selectAll(notice);
        return PageInfo.of(list);
    }

    public String getTitleById(Integer noticeId) {
        Notice notice = noticeMapper.selectById(noticeId);
        return notice != null ? notice.getTitle() : "未知标题"; // 处理空值
    }
}
