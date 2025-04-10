package com.example.controller;

import com.example.common.Result;
import com.example.entity.Worker;
import com.example.service.WorkerService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 管理员前端操作接口
 **/
@RestController
@RequestMapping("/worker")
public class WorkerController {

    @Resource
    private WorkerService workerService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Worker worker) {
        workerService.add(worker);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        workerService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        workerService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Worker worker) {
        workerService.updateById(worker);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Worker worker = workerService.selectById(id);
        return Result.success(worker);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Worker worker ) {
        List<Worker> list = workerService.selectAll(worker);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Worker worker,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Worker> page = workerService.selectPage(worker, pageNum, pageSize);
        return Result.success(page);
    }

}
