package com.example.controller;

import com.example.common.Result;
import com.example.service.MainPageService;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/main_page")
@CrossOrigin(origins = "*")
public class MainPageController {
    @Resource
    private MainPageService mainPageService;

    @GetMapping("/publicized")
    public Result getPublicized() {
        List<Map<String, Object>> publicizedData = mainPageService.getPublicized();
        return Result.success(publicizedData);
    }

}
