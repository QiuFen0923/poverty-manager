package com.example.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.common.Constants;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Feedback;
import com.example.exception.CustomException;
import com.example.mapper.FeedbackMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * 反馈业务处理
 **/
@Service
public class FeedbackService {

    @Resource
    private FeedbackMapper feedbackMapper;

    /**
     * 新增
     */
    public void add(Feedback feedback) {
        LocalDate currentDate = LocalDate.now();
        LocalTime currentTime = LocalTime.now();

        // 定义日期时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 格式化日期时间
        String dateTimeString = formatter.format(currentDate.atTime(currentTime));
        feedback.setTime(dateTimeString);

        feedbackMapper.insert(feedback);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        feedbackMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            feedbackMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Feedback feedback) {
        feedbackMapper.updateById(feedback);
    }

    /**
     * 根据ID查询
     */
    public Feedback selectById(Integer id) {
        return feedbackMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Feedback> selectAll(Feedback feedback) {
        return feedbackMapper.selectAll(feedback);
    }

    /**
     * 分页查询
     */
    public PageInfo<Feedback> selectPage(Feedback feedback, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        Account account =TokenUtils.getCurrentUser();

        if(RoleEnum.USER.name().equals(account.getRole())){
            feedback.setUserId(account.getId());
        }
        List<Feedback> list = feedbackMapper.selectAll(feedback);
        return PageInfo.of(list);
    }

}
