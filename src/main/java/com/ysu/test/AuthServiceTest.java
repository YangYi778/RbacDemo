package com.ysu.test;

import com.ysu.entity.Auth;
import com.ysu.entity.User;
import com.ysu.service.AuthService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

import static org.junit.Assert.*;

/**
 * @author Qiantao-H
 * @version 1.0
 * @date 2020/9/20 18:23
 */
public class AuthServiceTest {

    ApplicationContext context=null;
    @Before
    public void init(){
        context=new ClassPathXmlApplicationContext("spring.xml");
    }

    @Test
    public void testqueryChildAuths() {
        AuthService authService = (AuthService) context.getBean("authService");
        List<Auth> auths = authService.queryChildAuths(1);
        System.out.println(auths);
    }

    @Test
    public void testqueryAllAuths() {
        AuthService authService = (AuthService) context.getBean("authService");
        List<Auth> auths = authService.queryAllAuths();
    }

    @Test
    public void testqueryAuthByUser() {
        AuthService authService = (AuthService) context.getBean("authService");
        User user = new User();
        user.setUserId(1);
        List<Auth> authList = authService.queryAuthByUser(user);
        System.out.println(authList);
    }

    @Test
    public void testinsertAuth(){
        AuthService authService = (AuthService) context.getBean("authService");
        Auth auth = new Auth();
        auth.setName("数据管理");
        auth.setAuthUrl("permission/datamanage");
        auth.setAuthParentRoot(1);
        auth.setAuthIsRoot("否");
        authService.insertAuth(auth);
    };

    @Test
    public void testupdateAuth(){
        AuthService authService = (AuthService) context.getBean("authService");
        Auth auth = new Auth();
        auth.setId(15);
        auth.setName("数据清洗");
        auth.setAuthUrl("permission/datamanage");
        auth.setAuthParentRoot(1);
        auth.setAuthIsRoot("是");
        authService.updateAuth(auth);
    };

    @Test
    public void testdeleteAuth(){
        AuthService authService = (AuthService) context.getBean("authService");
        String name = "数据管理";
        authService.deleteAuth(name);
        name="数据清洗";
        authService.deleteAuth(name);
    };
}
