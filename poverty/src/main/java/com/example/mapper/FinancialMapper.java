package com.example.mapper;

import com.example.entity.Financial;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface FinancialMapper {
    List<Financial> selectAll(Financial financial);
    @Select("SELECT * FROM financial")
    List<Financial>  selectAll2();

    Financial selectById(Integer id);

    List<Financial> selectPage(@Param("start") Integer start, @Param("pageSize") Integer pageSize, @Param("financial") Financial financial);

    Integer selectCount(Financial financial);

    int insert(Financial financial);

    int updateById(Financial financial);

    int deleteById(Integer id);

    int deleteBatch(List<Integer> ids);
}