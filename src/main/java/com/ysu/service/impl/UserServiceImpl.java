package com.ysu.service.impl;

import com.ysu.entity.User;
import com.ysu.repository.UserRepository;
import com.ysu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import com.sun.mail.smtp.SMTPMessage;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by 万恶de亚撒西 on 2020/9/14.
 */
@Service(value = "userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<User> queryAllUser() {
        return userRepository.queryAllUser();
    }
/********************************************************************************************/
    @Override
    public User login(User user) {

        return userRepository.login(user);
    }

    @Override
    public String validateLoginName(String userName) {
        String uN = userRepository.validateLoginName(userName);
        if(uN!=null)
        {
            return "您输入的账号已经存在";
        }
        return "";
    }

    /**
     * 生成激活码--保存到数据库中, 保存用户的时候,同时要发送一份邮件到你的邮箱中
     *
     */
    @Override
    public void saveUser(User user, HttpServletRequest request) {
        // TODO Auto-generated method stub
        try {
            // 生成激活码
            String active = UUID.randomUUID().toString();
            user.setActive(active);
            user.setCreateDate(new Date());
            // 保存用户信息
            userRepository.saveUser(user);
            Properties props = new Properties(); // hashtable
            // 设置邮件服务器地址,采用163邮件服务器
            props.setProperty("mail.smtp.host", "smtp.163.com");
            // 邮件服务器需要权限,指定用户必须登录邮件服务器才能发送邮件
            props.setProperty("mail.smtp.auth", "true");

            // 创建Authenicator 实例,实现账号,密码鉴权
            Authenticator auth = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    // TODO Auto-generated method stub
                    return new PasswordAuthentication("13645650386@163.com",
                            "JRUCXHHMUFFGBDWV");
                }
            };
            // session对象与服务器建立连接
            Session session = Session.getInstance(props, auth);
            // 创建SMTPMessage对象,用于封装邮件相关信息,主题,发件人,邮件内容等.
            SMTPMessage message = new SMTPMessage(session);
            message.setSubject("用户注册激活,无须回复,按照指引激活");
            message.setContent(
                    "<a href='http://127.0.0.1:8080"+request.getContextPath()+"/user/active?activeCode="
                            + user.getActive()
                            + "' target='_blank'>恭喜您注册成功,请点该链接进行激活,无须回复!</a>",
                    "text/html;charset=utf-8");
            message.setFrom(new InternetAddress("13645650386@163.com"));
            // TO表示收件人,CC 抄送 ,BCC密送
            message.setRecipient(RecipientType.TO, new InternetAddress(
                    user.getEmail()));
            Transport.send(message); // 发送邮件
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

    }

    @Override
    public String active(String activeCode) {
        // TODO Auto-generated method stub
        User user = userRepository.getUserByActive(activeCode);
        if (user != null) {
            userRepository.active(activeCode);
            return "";
        } else {
            return "激活失败";
        }
    }

    @Override
    public User getUserByActive(String activeCode) {
        return userRepository.getUserByActive(activeCode);
    }
/******************************************************************************************/
    @Override
    public User queryUserById(Integer id) {
        return userRepository.queryUserById(id);
    }

    @Override
    public List<Integer> queryRoleIdsByUserId(Integer id) {
        return userRepository.queryRoleIdsByUserId(id);
    }

    @Override
    public void insertUserRoles(Map<String, Object> map) {
        userRepository.insertUserRoles(map);
    }

    @Override
    public void deleteUserRoles(Map<String, Object> map) {
        userRepository.deleteUserRoles(map);
    }

}
