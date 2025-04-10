package com.example.controller;

import com.example.entity.Financial;
import com.example.service.FinancialService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 财务管理控制器
 */
@Api(tags = "财务管理接口")
@RestController
@RequestMapping("/financial")
public class FinancialController {

    @Resource
    private FinancialService financialService;

    @PostMapping("/insert")
    public Map<String, Object> insert(@Validated @RequestBody Financial financial) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = financialService.insert(financial);
            result.put("code", 200);
            result.put("message", "新增成功");
            result.put("data", count);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "新增失败：" + e.getMessage());
        }
        return result;
    }

    @DeleteMapping("/delete/{id}")
    public Map<String, Object> deleteById(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = financialService.deleteById(id);
            result.put("code", 200);
            result.put("message", "删除成功");
            result.put("data", count);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "删除失败：" + e.getMessage());
        }
        return result;
    }

    @DeleteMapping("/delete/batch")
    public Map<String, Object> deleteBatch(@RequestBody List<Integer> ids) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = financialService.deleteBatch(ids);
            result.put("code", 200);
            result.put("message", "批量删除成功");
            result.put("data", count);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "批量删除失败：" + e.getMessage());
        }
        return result;
    }

    @PutMapping("/update")
    public Map<String, Object> updateById(@Validated @RequestBody Financial financial) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = financialService.updateById(financial);
            result.put("code", 200);
            result.put("message", "更新成功");
            result.put("data", count);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "更新失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/get/{id}")
    public Map<String, Object> selectById(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        try {
            Financial financial = financialService.selectById(id);
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", financial);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/list")
    public Map<String, Object> selectAll(Financial financial) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Financial> list = financialService.selectAll(financial);
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", list);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/page")
    public Map<String, Object> selectPage(@RequestBody Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 获取分页参数
            Integer pageNum = (Integer) params.get("pageNum");
            Integer pageSize = (Integer) params.get("pageSize");

            // 创建查询对象
            Financial financial = new Financial();

            // 设置查询条件
            if (params.get("title") != null) {
                financial.setTitle((String) params.get("title"));
            }
            if (params.get("status") != null) {
                financial.setStatus((String) params.get("status"));
            }

            // 执行分页查询
            List<Financial> list = financialService.selectPage(pageNum, pageSize, financial);
            Integer total = financialService.selectCount(financial);

            // 构建返回数据
            Map<String, Object> data = new HashMap<>();
            data.put("list", list);
            data.put("total", total);

            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", data);

            // 打印日志，方便调试
            System.out.println("查询参数：" + params);
            System.out.println("返回数据：" + result);

        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
            e.printStackTrace(); // 打印异常堆栈，方便调试
        }
        return result;
    }
}
