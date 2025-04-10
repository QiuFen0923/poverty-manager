package com.example.service;

import com.example.entity.Financial;
import com.example.mapper.FinancialMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FinancialService {

    private static final Logger logger = LoggerFactory.getLogger(FinancialService.class);

    @Resource
    private FinancialMapper financialMapper;

    public List<Financial> selectAll(Financial financial) {
        logger.info("查询所有财务记录, 条件: {}", financial);
        return financialMapper.selectAll2();
    }

    public Financial selectById(Integer id) {
        if (id == null) {
            throw new IllegalArgumentException("ID不能为空");
        }
        return financialMapper.selectById(id);
    }

    public List<Financial> selectPage(Integer pageNum, Integer pageSize, Financial financial) {
        logger.info("分页查询财务记录, 页码: {}, 每页数量: {}, 查询条件: {}", pageNum, pageSize, financial);
        // 计算起始位置
        int start = (pageNum - 1) * pageSize;

        // 如果 financial 对象为 null，创建一个新的空对象
        if (financial == null) {
            financial = new Financial();
        }

        // 只有在有查询条件时才设置相应的字段
        if (financial.getTitle() == null && financial.getStatus() == null) {
            // 如果没有查询条件，返回所有数据
            List<Financial> result = financialMapper.selectPage(start, pageSize, financial);
            logger.info("分页查询结果: {}", result);
            return result;
        }

        // 有查询条件时的处理
        List<Financial> result = financialMapper.selectPage(start, pageSize, financial);
        logger.info("分页查询结果: {}", result);
        return result;
    }

    public Integer selectCount(Financial financial) {
        logger.info("查询财务记录总数, 查询条件: {}", financial);
        Integer count = financialMapper.selectCount(financial);
        logger.info("查询结果总数: {}", count);
        return count;
    }

    @Transactional(rollbackFor = Exception.class)
    public int insert(Financial financial) {
        if (financial == null) {
            throw new IllegalArgumentException("财务记录不能为空");
        }
        if (!StringUtils.hasText(financial.getTitle())) {
            throw new IllegalArgumentException("标题不能为空");
        }
        logger.info("新增财务记录: {}", financial);
        return financialMapper.insert(financial);
    }

    @Transactional(rollbackFor = Exception.class)
    public int updateById(Financial financial) {
        if (financial == null || financial.getId() == null) {
            throw new IllegalArgumentException("财务记录或ID不能为空");
        }
        logger.info("更新财务记录: {}", financial);
        return financialMapper.updateById(financial);
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteById(Integer id) {
        if (id == null) {
            throw new IllegalArgumentException("ID不能为空");
        }
        logger.info("删除财务记录, id: {}", id);
        return financialMapper.deleteById(id);
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteBatch(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            throw new IllegalArgumentException("ID列表不能为空");
        }
        logger.info("批量删除财务记录, ids: {}", ids);
        return financialMapper.deleteBatch(ids);
    }
}