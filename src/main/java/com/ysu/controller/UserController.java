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
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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

    @RequestMapping(value = "register")
    public String register(){
        return "register";
    }

    /*
    * 新登录界面
    * */
    @RequestMapping(value = "newlogin")
    public String newlogin(){
        return "newlogin";
    }

    @ResponseBody
    @RequestMapping("doregister")
    public Object userRegister(User user,Model model, HttpServletRequest request){
        AjaxResult result = new AjaxResult();	//ajax返回的对象
        try {
            userService.saveUser(user,request);
            //System.out.println("1");
            //model.addAttribute("message", "注册成功");
            result.setSuccess(true);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            //System.out.println("2");
           // model.addAttribute("message", "注册失败");
            result.setSuccess(false);
        }
        //返回视图,注册页面
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/vaildationLongName",produces={"application/text;charset=utf-8"})
    public String vaildationLongName(String userName){
        //检查账号是否存在
        String result=userService.validateLoginName(userName);
        return result;
    }

    @RequestMapping(value="/active")
    public String active(Model model,String activeCode){
        try {
            String message= userService.active(activeCode);
            model.addAttribute("message", !message.equals("") ? message: "激活成功!");
        } catch (Exception e) {
            // TODO: handle exception

            model.addAttribute("messagee.printStackTrace();", "激活失败!");
        }
        return "login";

    }
    //用户退出
    @RequestMapping(value="/logout")
    public String logout(HttpSession session){
        //将用户信息从session中删除
        session.removeAttribute("user");
        return "login";
    }

    @RequestMapping("queryAllUser")
    public ModelAndView queryAllUser(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index");
        modelAndView.addObject("list",userService.queryAllUser());
        return modelAndView;
    }

    @RequestMapping(value="/doAjaxLogin")
    public Object doAjaxLogin(User user,Model model,HttpSession session) {
        //AjaxResult result = new AjaxResult();	//ajax返回的对象
        User u = userService.login(user);
        if(u == null){
            model.addAttribute("error_message", "您输入的账号与密码不正确,请核实!");
            return "login";
        }else if(u.getUserState().equals("1")){
            model.addAttribute("error_message", "您尚未激活,请打开您的邮箱进行激活操作!");
            return "login";
        }else{
            session.setAttribute("user", u);  //用户信息存在session中session_user
            //获取用户权限
            Auth root = null;
            List<Auth> auths = authService.queryAuthByUser(u);	//传入用户id
            Map<Integer,Auth> authMap = new HashMap<Integer, Auth>();
            for(Auth auth : auths) {
                Auth child = auth;
                if(child.getAuthParentRoot() == 0) {
                    root = auth;
                    authMap.put(child.getId(), child);
                }else {
                    Auth parent = authMap.get(child.getAuthParentRoot());
                    parent.getChildren() .add(child);
                    authMap.put(child.getId(), child);
                }
            }
            session.setAttribute("rootAuth", root);
            //result.setSuccess(true);
        }
        return "main";
    }
    /**
     * 用户首页——用于展示当前已存在的用户信息
     */
    @RequestMapping(value="index")
    public String index(@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,5);
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

    /**
     * 角色分配——用于实现为当前用户的角色分配
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value="assign")
    public String assign(Integer id, Model model) {
        //根据用户id查找所有
        User user = userService.queryUserById(id);
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
     * 分配角色——对应页面 >> 按钮
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
     * 取消分配角色——对应页面 << 按钮
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
