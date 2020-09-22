package com.ysu.web;

import com.ysu.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @author Qiantao-H
 * @version 1.0
 * @date 2020/9/22 8:17
 */
public class LoginInterceptor implements HandlerInterceptor {
    /*
    * 在控制器之前完成的逻辑操作
    * 方法的返回值决定逻辑是否执行，ture表示执行，false表示不执行
    * */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("user");
        if(user==null){
            String path = session.getServletContext().getContextPath();
            response.sendRedirect(path+"/login");
            System.out.println("成功");
            return false;
        }
        System.out.println("失败");
        return true;
    }
    /*
    * 在控制器执行完成之后执行的逻辑操作
    * */

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {

    }
}
