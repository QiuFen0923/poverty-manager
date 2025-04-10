package com.example.controller;

import com.example.common.Result;
import com.example.service.ViewMapService;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/home")
@CrossOrigin(origins = "*")
public class ViewMapController {

    @Resource
    private ViewMapService viewMapService;

    @GetMapping("/province")
    public Result getProvinceStats() {
        List<Map<String, Object>> stats = viewMapService.getProvinceStats();
        return Result.success(stats);
    }

    @GetMapping("/age")
    public Result getAgeStats() {
        List<Map<String, Object>> stats = viewMapService.getAgeStats();
        return Result.success(stats);
    }

    @GetMapping("/ethnic")
    public Result getEthnicStats() {
        List<Map<String, Object>> stats = viewMapService.getEthnicStats();
        return Result.success(stats);
    }

    @GetMapping("/count")
    public Result getPoorCount() {
        List<Map<String, Integer>> count = viewMapService.getPoorCount();
        return Result.success(count);
    }

}
