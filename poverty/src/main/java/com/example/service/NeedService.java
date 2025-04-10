package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.common.Constants;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Need;
import com.example.exception.CustomException;
import com.example.mapper.NeedMapper;
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
import java.util.Objects;

/**
 * 需求业务处理
 **/
@Service
public class NeedService {

    @Resource
    private NeedMapper needMapper;

    /**
     * 新增
     */
    public void add(Need need) {
        LocalDate currentDate = LocalDate.now();
        LocalTime currentTime = LocalTime.now();
        // 定义日期时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        // 格式化日期时间
        String dateTimeString = formatter.format(currentDate.atTime(currentTime));
        need.setTime(dateTimeString);

        needMapper.insert(need);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        needMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            needMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Need need) {
        need.setEvaluate(need.getEvaluate()+"星");
        needMapper.updateById(need);
    }

    /**
     * 根据ID查询
     */
    public Need selectById(Integer id) {
        return needMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Need> selectAll(Need need) {
        return needMapper.selectAll(need);
    }

    /**
     * 分页查询
     */
    public PageInfo<Need> selectPage(Need need, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Need> list = needMapper.selectAll(need);
        return PageInfo.of(list);
    }

    /**
     * 登录
     */
    public Account login(Account account) {
        Account dbNeed = needMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbNeed)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbNeed.getPassword())) {
            throw new CustomException(ResultCodeEnum.USER_ACCOUNT_ERROR);
        }
        // 生成token
        String tokenData = dbNeed.getId() + "-" + RoleEnum.ADMIN.name();
        String token = TokenUtils.createToken(tokenData, dbNeed.getPassword());
        dbNeed.setToken(token);
        return dbNeed;
    }

    /**
     * 注册
     */
    public void register(Account account) {
        Need need = new Need();
        BeanUtils.copyProperties(account, need);
        add(need);
    }

    /**
     * 修改密码
     */
    public void updatePassword(Account account) {
        Need dbNeed = needMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbNeed)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbNeed.getPassword())) {
            throw new CustomException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        dbNeed.setPassword(account.getNewPassword());
        needMapper.updateById(dbNeed);
    }

}
