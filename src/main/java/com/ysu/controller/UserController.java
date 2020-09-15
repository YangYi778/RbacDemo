package com.ysu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ysu.entity.AjaxResult;
import com.ysu.entity.Auth;
import com.ysu.entity.Role;
import com.ysu.entity.User;
import com.ysu.service.AuthService;
import com.ysu.service.RoleService;
import com.ysu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 万恶de亚撒西 on 2020/9/14.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private AuthService authService;

    @RequestMapping("/main")
    public String main(){
        return "main";
    }

    @RequestMapping(value = "login")
    public String login(){
        return "login";
    }


    @RequestMapping("/queryAllUser")
    public ModelAndView queryAllUser(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index");
        modelAndView.addObject("list",userService.queryAllUser());
        return modelAndView;
    }
    @ResponseBody
    @RequestMapping(value="doAjaxLogin")
    public Object doAjaxLogin(User user, HttpSession session) {
        System.out.println("user=====" + user);
        AjaxResult result = new AjaxResult();	//ajax返回的对象
        User u = userService.login(user);
        if(u != null) {
            session.setAttribute("user", u);
            //获取用户权限
            Auth root = null;
            List<Auth> auths = authService.queryAuthByUser(u);	//传入用户id
            System.out.println(">>>>>>>>>>>>>>>" + auths + "************");
            Map<Integer,Auth> authMap = new HashMap<Integer, Auth>();
            for(Auth auth : auths) {
                System.out.println("++++++++++++" + auth);
                Auth child = auth;
                if(child.getAuthParentRoot() == 0) {
                    root = auth;
                    authMap.put(child.getId(), child);
                }else {
                    System.out.println("@@@@@@@@@@@@@@"+authMap);
                    Auth parent = authMap.get(child.getAuthParentRoot());
                    System.out.println("------------"+ parent);
                    parent.getChildren().add(child);
                    authMap.put(child.getId(), child);
                }
            }
            session.setAttribute("rootAuth", root);

            result.setSuccess(true);
        }else {
            result.setSuccess(false);
        }
        return result;
    }
    /**
     * 用户首页
     */
    @RequestMapping(value="index")
    public String index(@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,1);
        List<User> users = userService.queryAllUser();
        for(User user: users) {
            System.out.println(user);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(users, 6);
        model.addAttribute("pageInfo",page);
        return "user/index";
    }

    @RequestMapping(value="assign")
    public String assign(Integer id, Model model) {
        //根据用户id查找所有
        User user = userService.queryUserById(id);
        System.out.println("user=== " + user + "--------->>>>");
        model.addAttribute("user", user);

        //查询所有角色
        List<Role> roles = roleService.queryAllRole();
        //建立分配的角色与未分配的角色集合
        List<Role> assignedRoles = new ArrayList();
        List<Role> unassignedRoles = new ArrayList();
        //根据用户id获取该用户拥有的角色id，因为已经查出所有角色，所以可以只根据角色id划分已分配与未分配角色
        List<Integer> roleIds = userService.queryRoleIdsByUserId(id);
        for(Role role : roles) {

            if(roleIds.contains(role.getRoleId())) {
                //当前用户已拥有的角色
                assignedRoles.add(role);
            }else {
                //当前用户未拥有的角色
                unassignedRoles.add(role);
            }
        }
        System.out.println("assignedRoles=====" + assignedRoles);
        System.out.println("unassignedRoles*******"+ unassignedRoles);
        model.addAttribute("assignedRoles",assignedRoles);
        model.addAttribute("unassignedRoles",unassignedRoles);
        return "user/assign";
    }

    /**
     * 分配角色
     */
    @ResponseBody
    @RequestMapping(value="doAssign")
    public Object doAssign(Integer userId, Integer[] unassignedRoles) {
//		String userId = request.getParameter("userId");
//		String[] unassignRoleIds = request.getParameterValues("unassignedRoles");
        System.out.println("userId == " + userId);
        System.out.println("unassignedRoles == " + unassignedRoles);
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("roleIds", unassignedRoles);
            userService.insertUserRoles(map);
            result.setSuccess(true);
        } catch(Exception e) {
            result.setSuccess(false);
        }
        return result;

    }
    /**
     * 分配角色
     */
    @ResponseBody
    @RequestMapping(value="dounAssign")
    public Object delete(Integer userId, Integer[] assignedRoles) {
//		String userId = request.getParameter("userId");
//		String[] unassignRoleIds = request.getParameterValues("unassignedRoles");
        System.out.println("dounAssign+++++userId == " + userId);
        System.out.println("dounAssign+++++assignedRoles == " + assignedRoles);
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("roleIds", assignedRoles);
            userService.deleteUserRoles(map);
            result.setSuccess(true);
        } catch(Exception e) {
            result.setSuccess(false);
        }
        return result;

    }
}
