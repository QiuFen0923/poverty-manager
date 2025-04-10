package com.example.service;


import com.example.mapper.ViewMapMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ViewMapService {

    private static final Logger logger = LoggerFactory.getLogger(MessageService.class);


    @Resource
    private ViewMapMapper viewMapMapper;

    public List<Map<String, Object>> getProvinceStats() {
        return viewMapMapper.getProvinceStats();
    }

    public List<Map<String, Object>> getAgeStats() {
        return viewMapMapper.getAgeStats();
    }

    public List<Map<String, Object>> getEthnicStats() {
        return viewMapMapper.getEthnicStats();
    }

    public List<Map<String, Integer>> getPoorCount(){return viewMapMapper.getPoorCount();};
}
