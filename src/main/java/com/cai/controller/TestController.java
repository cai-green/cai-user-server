package com.cai.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author cai
 * @className TestController
 * @description 测试
 * @dateTime 2025/2/27 下午3:23
 */
@RestController
@RequestMapping("/test")
public class TestController {

    @GetMapping("/hello")
    public String test() {
        return "你好";
    }

    @GetMapping("/one")
    public String one() {
        return "第一次尝试actions，希望一次成功";
    }
}
