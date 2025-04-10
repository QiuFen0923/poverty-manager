package com.example.mapper;

import com.example.entity.Message;
import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface MessageMapper {
    List<Message> selectAll(Message message);

    Message selectById(Integer id);

    List<Message> selectPage(@Param("start") Integer start, @Param("pageSize") Integer pageSize,
            @Param("message") Message message);

    Integer selectCount(Message message);

    int insert(Message message);

    int updateById(Message message);

    int deleteById(Integer id);

    int deleteBatch(List<Integer> ids);

    @MapKey("province")
    List<Map<String, Object>> getProvinceStats();
}