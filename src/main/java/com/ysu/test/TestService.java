package com.ysu.test;


import com.ysu.entity.User;
import com.ysu.repository.UserRepository;
import com.ysu.service.UserService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

import static com.mchange.v2.c3p0.impl.C3P0Defaults.user;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
public class TestService {

    ApplicationContext context=null;
    @Before
    public void init(){
        context=new ClassPathXmlApplicationContext("applicationContext.xml");
    }
    @Test
    public void test1(){
        UserService userService=(UserService) context.getBean("userService");
        User u=new User();
        u.setUserName("admin");
        u.setPassword("123456");
        User user=userService.login(u);
        System.out.println(user);
    }
    @Test
    public void test2(){

        UserService userService=(UserService) context.getBean("userService");

        String message=userService.validateLoginName("test1");
        System.out.println(message+"***");
    }
    @Test
    public void testQueryAllUser(){
        ApplicationContext context = new ClassPathXmlApplicationContext("spring.xml");
        UserService userService = (UserService)context.getBean("userService");
        List<User> users = userService.queryAllUser();
        System.out.println("user====" + users);
    }
}
