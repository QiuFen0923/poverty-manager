package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.common.Constants;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Worker;
import com.example.exception.CustomException;
import com.example.mapper.WorkerMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 基层工作人员业务处理
 **/
@Service
public class WorkerService {

    @Resource
    private WorkerMapper workerMapper;

    /**
     * 新增
     */
    public void add(Worker worker) {
        worker.setPassword("123");
        workerMapper.insert(worker);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        workerMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            workerMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Worker worker) {
        workerMapper.updateById(worker);
    }

    /**
     * 根据ID查询
     */
    public Worker selectById(Integer id) {
        return workerMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Worker> selectAll(Worker worker) {
        return workerMapper.selectAll(worker);
    }

    /**
     * 分页查询
     */
    public PageInfo<Worker> selectPage(Worker worker, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Worker> list = workerMapper.selectAll(worker);
        return PageInfo.of(list);
    }

    /**
     * 登录
     */
    public Account login(Account account) {
        Account dbWorker = workerMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbWorker)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbWorker.getPassword())) {
            throw new CustomException(ResultCodeEnum.USER_ACCOUNT_ERROR);
        }
        // 生成token
        String tokenData = dbWorker.getId() + "-" + RoleEnum.WORKER.name();
        String token = TokenUtils.createToken(tokenData, dbWorker.getPassword());
        dbWorker.setToken(token);
        return dbWorker;
    }

    /**
     * 注册
     */
    public void register(Account account) {
        Worker worker = new Worker();
        BeanUtils.copyProperties(account, worker);
        add(worker);
    }

    /**
     * 修改密码
     */
    public void updatePassword(Account account) {
        Worker dbWorker = workerMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbWorker)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbWorker.getPassword())) {
            throw new CustomException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        dbWorker.setPassword(account.getNewPassword());
        workerMapper.updateById(dbWorker);
    }

}
