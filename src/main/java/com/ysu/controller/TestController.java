package com.ysu.controller;

import com.ysu.entity.User;
import com.ysu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
@Controller
public class TestController {

    @Autowired
    private UserService userService;
    @RequestMapping(value = "login")
    public String login(){
        return "login";
    }
    @ResponseBody
    @RequestMapping(value = "json")
    public Object json(){
        Map map = new HashMap();
        map.put("username","hello");
        return map;

    }
    @RequestMapping(value = "queryAllUser")
    public String queryAllUser(){
        System.out.println("test queryAllUser_______");
        List<User> users = userService.queryAllUser();
        System.out.println("user=====" + users);
        return "login";
    }

}
