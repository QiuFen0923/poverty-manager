package com.example.service.impl;

import com.example.entity.Message;
import com.example.mapper.MessageMapper;
import com.example.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageMapper messageMapper;

    @Override
    public List<Message> selectAll(Message message) {
        return messageMapper.selectAll(message);
    }

    @Override
    public Message selectById(Integer id) {
        return messageMapper.selectById(id);
    }

    @Override
    public List<Message> selectPage(Message message, Integer start, Integer pageSize) {
        return messageMapper.selectPage(message, start, pageSize);
    }

    @Override
    public Integer selectCount(Message message) {
        return messageMapper.selectCount(message);
    }

    @Override
    public void deleteById(Integer id) {
        messageMapper.deleteById(id);
    }

    @Override
    public void deleteBatch(List<Integer> ids) {
        messageMapper.deleteBatch(ids);
    }

    @Override
    public void insert(Message message) {
        messageMapper.insert(message);
    }

    @Override
    public void updateById(Message message) {
        messageMapper.updateById(message);
    }

    @Override
    public List<Map<String, Object>> getProvinceStats() {
        return messageMapper.getProvinceStats();
    }
}