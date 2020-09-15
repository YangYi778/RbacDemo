package com.ysu.web;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by 万恶de亚撒西 on 2020/9/14.
 */
public class ServiceListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext application = servletContextEvent.getServletContext();
        String path = application.getContextPath();
        System.out.println(">>>>>>>>>>>>"+ path);
        application.setAttribute("PATH",path);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
