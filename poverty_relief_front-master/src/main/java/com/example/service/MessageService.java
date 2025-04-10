package com.example.service;

import com.example.entity.Message;
import java.util.List;
import java.util.Map;

public interface MessageService {
    List<Message> selectAll(Message message);

    Message selectById(Integer id);

    List<Message> selectPage(Message message, Integer start, Integer pageSize);

    Integer selectCount(Message message);

    void deleteById(Integer id);

    void deleteBatch(List<Integer> ids);

    void insert(Message message);

    void updateById(Message message);

    // 获取省份统计数据
    List<Map<String, Object>> getProvinceStats();
}