package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.common.Constants;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Archives;
import com.example.exception.CustomException;
import com.example.mapper.ArchivesMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 贫困档案业务处理
 **/
@Service
public class ArchivesService {

    @Resource
    private ArchivesMapper archivesMapper;

    /**
     * 新增
     */
    public void add(Archives archives) {
        archivesMapper.insert(archives);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        archivesMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            archivesMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Archives archives) {
        archivesMapper.updateById(archives);
    }

    /**
     * 根据ID查询
     */
    public Archives selectById(Integer id) {
        return archivesMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Archives> selectAll(Archives archives) {
        return archivesMapper.selectAll(archives);
    }

    /**
     * 分页查询
     */
    public PageInfo<Archives> selectPage(Archives archives, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Archives> list = archivesMapper.selectAll(archives);
        return PageInfo.of(list);
    }

    /**
     * 登录
     */
    public Account login(Account account) {
        Account dbArchives = archivesMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbArchives)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbArchives.getPassword())) {
            throw new CustomException(ResultCodeEnum.USER_ACCOUNT_ERROR);
        }
        // 生成token
        String tokenData = dbArchives.getId() + "-" + RoleEnum.ADMIN.name();
        String token = TokenUtils.createToken(tokenData, dbArchives.getPassword());
        dbArchives.setToken(token);
        return dbArchives;
    }

    /**
     * 注册
     */
    public void register(Account account) {
        Archives archives = new Archives();
        BeanUtils.copyProperties(account, archives);
        add(archives);
    }

    /**
     * 修改密码
     */
    public void updatePassword(Account account) {
        Archives dbArchives = archivesMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbArchives)) {
            throw new CustomException(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
        if (!account.getPassword().equals(dbArchives.getPassword())) {
            throw new CustomException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        dbArchives.setPassword(account.getNewPassword());
        archivesMapper.updateById(dbArchives);
    }

}
