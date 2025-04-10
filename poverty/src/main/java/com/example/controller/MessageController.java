package com.example.controller;

import com.example.common.Result;
import com.example.entity.Message;
import com.example.service.MessageService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 信息管理控制器
 */
@Api(tags = "信息管理接口")
@RestController
@RequestMapping("/message")
public class MessageController {

    @Resource
    private MessageService messageService;



    @PostMapping("/insert")
    public Map<String, Object> insert(@Validated @RequestBody Message message) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = messageService.insert(message);
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
            int count = messageService.deleteById(id);
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
            int count = messageService.deleteBatch(ids);
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
    public Map<String, Object> updateById(@Validated @RequestBody Message message) {
        Map<String, Object> result = new HashMap<>();
        try {
            int count = messageService.updateById(message);
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
            Message message = messageService.selectById(id);
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", message);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/list")
    public Map<String, Object> selectAll(@RequestBody Message message) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Message> list = messageService.selectAll(message);
            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", list);
        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/suggestion")
    public Map<String, Object> submitObjection(@RequestBody Map<String, Object> payload) {
        Integer id = (Integer) payload.get("id");
        String suggestion = (String) payload.get("suggestion");
        Map<String, Object> result = new HashMap<>();

        Message message = messageService.selectById(id);
        if (message == null) {
            result.put("code", 500);
            result.put("message", "查找失败：");
        }

        message.setCurrentstate("异议待处理");
        message.setSuggestion(suggestion);
        updateById(message);

        result.put("code", 200);
        result.put("message", "查询成功");
        result.put("data", message);


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
            Message message = new Message();

            // 设置查询条件
            if (params.get("sfz") != null) {
                message.setSfz((String) params.get("sfz"));
            }
            if (params.get("poorstate") != null) {
                message.setPoorstate((String) params.get("poorstate"));
            }

            // 执行分页查询
            List<Message> list = messageService.selectPage(pageNum, pageSize, message);
            Integer total = messageService.selectCount(message);

            // 构建返回数据
            Map<String, Object> data = new HashMap<>();
            data.put("list", list);
            data.put("total", total);

            result.put("code", 200);
            result.put("message", "查询成功");
            result.put("data", data);

        } catch (Exception e) {
            result.put("code", 500);
            result.put("message", "查询失败：" + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }
}