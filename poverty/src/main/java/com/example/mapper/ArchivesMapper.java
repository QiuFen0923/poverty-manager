package com.example.mapper;

import com.example.entity.Archives;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作archives相关数据接口
*/
public interface ArchivesMapper {

    /**
      * 新增
    */
    int insert(Archives archives);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Archives archives);

    /**
      * 根据ID查询
    */
    Archives selectById(Integer id);

    /**
      * 查询所有
    */
    List<Archives> selectAll(Archives archives);

    @Select("select * from archives where username = #{username}")
    Archives selectByUsername(String username);
}
