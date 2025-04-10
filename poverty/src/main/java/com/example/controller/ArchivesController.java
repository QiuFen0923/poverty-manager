package com.example.controller;

import com.example.common.Result;
import com.example.entity.Archives;
import com.example.service.ArchivesService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 管理员前端操作接口
 **/
@RestController
@RequestMapping("/archives")
public class ArchivesController {

    @Resource
    private ArchivesService archivesService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Archives archives) {
        archivesService.add(archives);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        archivesService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        archivesService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Archives archives) {
        archivesService.updateById(archives);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Archives archives = archivesService.selectById(id);
        return Result.success(archives);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Archives archives ) {
        List<Archives> list = archivesService.selectAll(archives);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Archives archives,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Archives> page = archivesService.selectPage(archives, pageNum, pageSize);
        return Result.success(page);
    }

}
