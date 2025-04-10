package com.example.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.example.common.Result;
import com.example.common.enums.ResultCodeEnum;
import com.example.common.enums.RoleEnum;
import com.example.entity.Account;
import com.example.service.AdminService;
import com.example.service.UserService;
import com.example.service.WorkerService;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 基础前端接口
 */
@RestController
public class WebController {

    @Resource
    private AdminService adminService;
    @Resource
    private UserService userService;
    @Resource
    private WorkerService workerService;


    /**
     * 登录
     */
    @PostMapping("/login")
    public Result login(@RequestBody Account account) {
        if (ObjectUtil.isEmpty(account.getUsername()) || ObjectUtil.isEmpty(account.getPassword())
                || ObjectUtil.isEmpty(account.getRole())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            account = adminService.login(account);
            return Result.success(account);
        }
        if (RoleEnum.WORKER.name().equals(account.getRole())) {
            return Result.success(workerService.login(account));
        }
        if (RoleEnum.USER.name().equals(account.getRole())) {
            return Result.success(userService.login(account));
        }
        return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
    }

    /**
     * 注册
     */
    @PostMapping("/register")
    public Result register(@RequestBody Account account) {
        if (StrUtil.isBlank(account.getUsername()) || StrUtil.isBlank(account.getPassword())
                || ObjectUtil.isEmpty(account.getRole())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }
        if (RoleEnum.USER.name().equals(account.getRole())) {
            userService.register(account);
        }
        return Result.success();
    }

    /**
     * 修改密码
     */
    @PutMapping("/updatePassword")
    public Result updatePassword(@RequestBody Account account) {
        if (StrUtil.isBlank(account.getUsername()) || StrUtil.isBlank(account.getPassword())
                || ObjectUtil.isEmpty(account.getNewPassword())) {
            return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
        }
        if (RoleEnum.ADMIN.name().equals(account.getRole())) {
            adminService.updatePassword(account);
        }
        if (RoleEnum.WORKER.name().equals(account.getRole())) {
            workerService.updatePassword(account);
        }
        if (RoleEnum.USER.name().equals(account.getRole())) {
            userService.updatePassword(account);
        }
        return Result.success();
    }

    /**
     *检查用户名是否存在
     */
    @PostMapping("/check-username")
    public Result checkUsername(@RequestBody Account account) {
        String username = account.getUsername();
        if (userService.checkUsernameExists(username)) {
            return Result.success();
        } else {
            return Result.error(ResultCodeEnum.USER_NOT_EXIST_ERROR);
        }
    }

    /**
     *重置密码
     */
    @PostMapping("/reset-password")
    public Result resetPassword(@RequestBody Account account) {
        if (StrUtil.isNotBlank(account.getUsername()) && StrUtil.isNotBlank(account.getNewPassword())) {
            if (RoleEnum.ADMIN.name().equals(account.getRole())) {
                adminService.updatePassword(account);
            } else if (RoleEnum.WORKER.name().equals(account.getRole())) {
                workerService.updatePassword(account);
            } else if (RoleEnum.USER.name().equals(account.getRole())) {
                userService.updatePassword(account);
            }
            return Result.success();
        }
        return Result.error(ResultCodeEnum.PARAM_LOST_ERROR);
    }

    //获取路由权限，这边懒得写了，写死
    @GetMapping(value = "/getPermissions", produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> getPermissions(@RequestParam(value = "role") String role) {
        // 创建子项列表
        if (role.equals("USER")) {
            System.out.println("2313213");
            List<Map<String, String>> children = new ArrayList<>();
            Map<String, String> child1 = new HashMap<>();
            child1.put("name", "资讯详情");
            children.add(child1);

            Map<String, String> child2 = new HashMap<>();
            child2.put("name", "主页");
            children.add(child2);
            Map<String, String> child3 = new HashMap<>();
            child3.put("name", "贫困申请");
            children.add(child3);
            Map<String, String> child4 = new HashMap<>();
            child4.put("name", "需求申请");
            children.add(child4);
            Map<String, String> child5 = new HashMap<>();
            child5.put("name", "个人信息");
            children.add(child5);
            Map<String, String> child6 = new HashMap<>();
            child6.put("name", "查看回复");
            children.add(child6);
            Map<String, String> child7 = new HashMap<>();
            child7.put("name", "更多");
            children.add(child7);

            // 创建父项
            Map<String, Object> parent = new HashMap<>();
            parent.put("name", "前台");
            parent.put("children", children);

            // 创建数据列表
            List<Map<String, Object>> data = new ArrayList<>();
            data.add(parent);

            // 创建响应对象
            Map<String, Object> response = new HashMap<>();
            response.put("code", 200);
            response.put("message", "获取权限成功");
            response.put("data", data);
            return response;
        }else {
            List<Map<String, String>> children = new ArrayList<>();
            Map<String, String> child1 = new HashMap<>();
            child1.put("name", "管理员信息");
            children.add(child1);

            Map<String, String> child2 = new HashMap<>();
            child2.put("name", "系统首页");
            children.add(child2);
            Map<String, String> child3 = new HashMap<>();
            child3.put("name", "反馈信息");
            children.add(child3);
            Map<String, String> child4 = new HashMap<>();
            child4.put("name", "工作人员信息");
            children.add(child4);
            Map<String, String> child5 = new HashMap<>();
            child5.put("name", "用户信息");
            children.add(child5);
            Map<String, String> child6 = new HashMap<>();
            child6.put("name", "修改密码");
            children.add(child6);
            Map<String, String> child7 = new HashMap<>();
            child7.put("name", "公告信息");
            children.add(child7);
            Map<String, String> child8 = new HashMap<>();
            child8.put("name", "政策信息");
            children.add(child8);
            Map<String, String> child9 = new HashMap<>();
            child9.put("name", "资讯信息");
            children.add(child9);
            Map<String, String> child10 = new HashMap<>();
            child10.put("name", "评论信息");
            children.add(child10);
            Map<String, String> child11 = new HashMap<>();
            child11.put("name", "公告信息");
            children.add(child11);
            Map<String, String> child12 = new HashMap<>();
            child12.put("name", "阳光操作管理");
            children.add(child12);
            Map<String, String> child13 = new HashMap<>();
            child13.put("name", "数据统计");
            children.add(child13);
            Map<String, String> child14 = new HashMap<>();
            child14.put("name", "贫困信息");
            children.add(child14);

            // 创建父项
            Map<String, Object> parent = new HashMap<>();
            parent.put("name", "后台");
            parent.put("children", children);

            // 创建数据列表
            List<Map<String, Object>> data = new ArrayList<>();
            data.add(parent);

            // 创建响应对象
            Map<String, Object> response = new HashMap<>();
            response.put("code", 200);
            response.put("message", "获取权限成功");
            response.put("data", data);
            return response;
        }

    }

}
