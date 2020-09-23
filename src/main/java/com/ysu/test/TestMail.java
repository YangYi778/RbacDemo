package com.ysu.test;

/**
 * @author Qiantao-H
 * @version 1.0
 * @date 2020/9/17 0017 23:25
 */
import java.util.Properties;
import java.util.UUID;
import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import com.sun.mail.smtp.SMTPMessage;

public class TestMail {

    public static void main(String[] args) {
        // TODO Auto-generated method stub
        try {
            Properties props=new Properties();  //hashtable
            //设置邮件服务器地址,采用163邮件服务器
            props.setProperty("mail.smtp.host", "smtp.163.com");
            //邮件服务器需要权限,指定用户必须登录邮件服务器才能发送邮件
            props.setProperty("mail.smtp.auth", "true");

            //创建Authenicator 实例,实现账号,密码鉴权
            Authenticator auth=new Authenticator(){
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    // TODO Auto-generated method stub
                    return new PasswordAuthentication("13645650386@163.com","JRUCXHHMUFFGBDWV");
                }
            };
            //session对象与服务器建立连接
            Session session =Session.getInstance(props,auth);
            //创建SMTPMessage对象,用于封装邮件相关信息,主题,发件人,邮件内容等.
            SMTPMessage message=new SMTPMessage(session);
            message.setSubject("用户注册激活,无须回复,按照指引激活");
            message.setContent("<a href='http://127.0.0.1:8080/user/active?activeCode="+UUID.randomUUID().toString()+"' target='_blank'>恭喜您注册成功,请点该链接进行激活,无须回复!</a>", "text/html;charset=utf-8");
            message.setFrom(new InternetAddress("13645650386@163.com"));
            //TO表示收件人,CC 抄送   ,BCC密送
            message.setRecipient(RecipientType.TO, new InternetAddress("huqiantao183@163.com"));
            System.out.println("****1***");
            Transport.send(message);   //发送邮件
            System.out.println("*******");
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }
}

