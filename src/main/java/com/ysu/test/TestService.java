package com.ysu.test;


import com.ysu.entity.User;
import com.ysu.service.UserService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
public class TestService {

    @Test
    public void testQueryAllUser(){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        UserService userService = (UserService)context.getBean("userService");
        List<User> users = userService.queryAllUser();
        System.out.println("user====" + users);
    }
}
