package com.example.mapper;

import com.example.entity.Need;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作need相关数据接口
*/
public interface NeedMapper {

    /**
      * 新增
    */
    int insert(Need need);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Need need);

    /**
      * 根据ID查询
    */
    Need selectById(Integer id);

    /**
      * 查询所有
    */
    List<Need> selectAll(Need need);

    @Select("select * from need where username = #{username}")
    Need selectByUsername(String username);
}
