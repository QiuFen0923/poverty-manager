package com.example.mapper;

import com.example.entity.Worker;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作worker相关数据接口
*/
public interface WorkerMapper {

    /**
      * 新增
    */
    int insert(Worker worker);

    /**
      * 删除
    */
    int deleteById(Integer id);

    /**
      * 修改
    */
    int updateById(Worker worker);

    /**
      * 根据ID查询
    */
    Worker selectById(Integer id);

    /**
      * 查询所有
    */
    List<Worker> selectAll(Worker worker);

    @Select("select * from worker where username = #{username}")
    Worker selectByUsername(String username);
}
