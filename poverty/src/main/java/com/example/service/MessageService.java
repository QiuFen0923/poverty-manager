package com.example.service;

import com.example.entity.Message;
import com.example.mapper.MessageMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;


@Service
public class MessageService {

    private static final Logger logger = LoggerFactory.getLogger(MessageService.class);

    @Resource
    private MessageMapper messageMapper;


    public List<Message> selectAll(Message message) {
        logger.info("查询所有记录, 条件: {}", message);
        return messageMapper.selectAll(message);
    }

    public Message selectById(Integer id) {
        if (id == null) {
            throw new IllegalArgumentException("ID不能为空");
        }
        return messageMapper.selectById(id);
    }

    public List<Message> selectPage(Integer pageNum, Integer pageSize, Message message) {
        logger.info("分页查询记录, 页码: {}, 每页数量: {}, 查询条件: {}", pageNum, pageSize, message);
        // 计算起始位置
        int start = (pageNum - 1) * pageSize;

        // 如果 message 对象为 null，创建一个新的空对象
        if (message == null) {
            message = new Message();
        }

        // 执行分页查询
        List<Message> result = messageMapper.selectPage(start, pageSize, message);
        logger.info("分页查询结果: {}", result);
        return result;
    }

    public Integer selectCount(Message message) {
        logger.info("查询记录总数, 查询条件: {}", message);
        Integer count = messageMapper.selectCount(message);
        logger.info("查询结果总数: {}", count);
        return count;
    }

    @Transactional(rollbackFor = Exception.class)
    public int insert(Message message) {
        if (message == null) {
            throw new IllegalArgumentException("记录不能为空");
        }
        if (!StringUtils.hasText(message.getPoorreason())) {
            throw new IllegalArgumentException("致贫原因不能为空");
        }
        logger.info("新增记录: {}", message);
        return messageMapper.insert(message);
    }

    @Transactional(rollbackFor = Exception.class)
    public int updateById(Message message) {
        if (message == null || message.getId() == null) {
            throw new IllegalArgumentException("记录或ID不能为空");
        }
        logger.info("更新记录: {}", message);
        return messageMapper.updateById(message);
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteById(Integer id) {
        if (id == null) {
            throw new IllegalArgumentException("ID不能为空");
        }
        logger.info("删除记录, id: {}", id);
        return messageMapper.deleteById(id);
    }

    @Transactional(rollbackFor = Exception.class)
    public int deleteBatch(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            throw new IllegalArgumentException("ID列表不能为空");
        }
        logger.info("批量删除记录, ids: {}", ids);
        return messageMapper.deleteBatch(ids);
    }


}