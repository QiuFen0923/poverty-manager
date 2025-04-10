package com.example.mapper;


import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ViewMapMapper {

    @MapKey("province")
    List<Map<String, Object>> getProvinceStats();

    @MapKey("age")
    List<Map<String, Object>> getAgeStats();

    @MapKey("ethnic")
    List<Map<String, Object>> getEthnicStats();

    @MapKey("poorstate")
    List<Map<String, Integer>> getPoorCount();
}
