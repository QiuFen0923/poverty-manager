package com.example.service;

import com.example.mapper.MainPageMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class MainPageService {

    @Resource
    private MainPageMapper mainPageMapper;

    public List<Map<String, Object>> getPublicized() {
        return mainPageMapper.getPublicized();
    }
}
