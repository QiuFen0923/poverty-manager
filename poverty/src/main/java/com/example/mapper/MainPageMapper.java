package com.example.mapper;


import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Mapper;


import java.util.List;
import java.util.Map;


@Mapper
public interface MainPageMapper {

    @MapKey("currentstate")
    List<Map<String, Object>> getPublicized();
}
