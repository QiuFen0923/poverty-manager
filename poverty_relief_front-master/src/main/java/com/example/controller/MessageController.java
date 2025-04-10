package com.example.controller;

import com.example.common.Result;
import com.example.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @GetMapping("/province/stats")
    public Result getProvinceStats() {
        List<Map<String, Object>> stats = messageService.getProvinceStats();
        return Result.success(stats);
    }
}