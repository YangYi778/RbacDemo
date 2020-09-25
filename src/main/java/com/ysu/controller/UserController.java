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
    public String main() {
        return "main";
    }

    @RequestMapping(value = "login")
    public String login() {
        return "login";
    }

    @RequestMapping(value = "register")
    public String register() {
        return "register";
    }

    /*
     * 新登录界面
     * */
    @RequestMapping(value = "newlogin")
    public String newlogin() {
        return "/newlogin.jsp";
    }

    @ResponseBody
    @RequestMapping("doregister")
    public Object userRegister(User user, Model model, HttpServletRequest request) {
        AjaxResult result = new AjaxResult();    //ajax返回的对象
        try {
            userService.saveUser(user, request);

            System.out.println("1");
            Integer a[] = {6};
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", user.getUserId());
            map.put("roleIds", a);
            userService.insertUserRoles(map);
            result.setSuccess(true);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            System.out.println("2");
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/vaildationLongName", produces = {"application/text;charset=utf-8"})
    public String vaildationLongName(String userName) {
        //检查账号是否存在
        String result = userService.validateLoginName(userName);
        return result;
    }

    @RequestMapping(value = "/active")
    public String active(Model model, String activeCode) {
        try {
            String message = userService.active(activeCode);
            model.addAttribute("message", !message.equals("") ? message : "激活成功!");
        } catch (Exception e) {
            // TODO: handle exception

            model.addAttribute("messagee.printStackTrace();", "激活失败!");
        }
        return "login";

    }

    //用户退出
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        //将用户信息从session中删除
        session.removeAttribute("user");
        return "login";
    }

    @RequestMapping("queryAllUser")
    public ModelAndView queryAllUser() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("index");
        modelAndView.addObject("list", userService.queryAllUser());
        return modelAndView;
    }

    //登录验证
    @RequestMapping(value = "/doAjaxLogin")
    public Object doAjaxLogin(User user, Model model, HttpSession session) {
        //AjaxResult result = new AjaxResult();	//ajax返回的对象
        User u = userService.login(user);
        if (u == null) {
            model.addAttribute("error_message", "您输入的账号与密码不正确,请核实!");
            return "login";
        } else if (u.getUserState().equals("1")) {
            model.addAttribute("error_message", "您尚未激活,请打开您的邮箱进行激活操作!");
            return "login";
        } else {
            session.setAttribute("user", u);  //用户信息存在session中session_user
            //获取用户权限
            Auth root = null;
            List<Auth> auths = authService.queryAuthByUser(u);    //传入用户id
            Map<Integer, Auth> authMap = new HashMap<Integer, Auth>();
            for (Auth auth : auths) {
                authMap.put(auth.getId(), auth);
            }
            for (Auth auth : auths) {
                Auth child = auth;
                if (child.getAuthParentRoot() == 0) {
                    root = auth;
                    authMap.put(child.getId(), child);
                } else {
                    Auth parent = authMap.get(child.getAuthParentRoot());
                    parent.getChildren().add(child);
                    authMap.put(child.getId(), child);
                }
            }
            session.setAttribute("rootAuth", root);
        }
        return "main";
    }

    /**
     * 用户首页——用于展示当前已存在的用户信息
     */
    @RequestMapping(value = "index")
    public String index(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn, 5);
        List<User> users = userService.queryAllUser();
        for (User user : users) {
            System.out.println(user);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(users, 6);
        model.addAttribute("pageInfo", page);
        return "user/index";
    }

    /**
     * 角色分配——用于实现为当前用户的角色分配
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "assign")
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
        for (Role role : roles) {
            if (roleIds.contains(role.getRoleId())) {
                //当前用户已拥有的角色
                assignedRoles.add(role);
            } else {
                //当前用户未拥有的角色
                unassignedRoles.add(role);
            }
        }
        System.out.println("assignedRoles=====" + assignedRoles);
        System.out.println("unassignedRoles*******" + unassignedRoles);
        model.addAttribute("assignedRoles", assignedRoles);
        model.addAttribute("unassignedRoles", unassignedRoles);
        return "user/assign";
    }

    /**
     * 权限分配——对当前选中的角色 进行权限分配
     * 为当前ID角色 分配权限
     * 角色---》权限
     */
    @RequestMapping("/assignPermission")
    public String assignPermission(Integer id, Model model) {
        //根据用户id查找所有
        //User user = userService.queryUserById(id);
        Role role = roleService.queryRoleById(id);
        System.out.println("rolePermission=== " + role + "--------->>>>");
        model.addAttribute("role", role);

        //查询所有权限
        List<Auth> auths = authService.queryAllAuths();
        //建立分配的角色与未分配的角色集合
        List<Auth> assignedPermission = new ArrayList();
        List<Auth> unassignedPermission = new ArrayList();

        //查询该用户 已分配权限
        // List<Integer> authIds = userService.queryRoleIdsByUserId(id);
        List<Integer> authIds = authService.queryAuthIdsByRoleId(id);

        int j = 0;
        for (Auth auth : auths) {

            //auth  是遍历对象  auths是被遍历的列表
            if (authIds.contains(auth.getId())) {
                assignedPermission.add(auth);
            } else {
                //当前用户未拥有的权限
                unassignedPermission.add(auth);
            }
        }
        System.out.println("assignedPermission=====" + assignedPermission);
        System.out.println("unassignedPermission*******" + unassignedPermission);
        model.addAttribute("assignedPermission", assignedPermission);
        model.addAttribute("unassignedPermission", unassignedPermission);
        model.addAttribute("roleId", role.getRoleId());
        return "user/assignPermission";
    }

    /**
     * 分配角色——对应页面 >> 按钮
     */
    @ResponseBody
    @RequestMapping(value = "doAssign")
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
        } catch (Exception e) {
            result.setSuccess(false);
        }
        return result;

    }

    // 权限分配的 》》
    @ResponseBody
    @RequestMapping(value = "doAssignPermission")
    public Object doAssignPermission(Integer roleId, Integer[] unassignedPermission) {
        // System.out.println("roleIdPermission == " + roleId);
        Auth auth;
        Auth parentAuth;
        Integer count = 0, k = 0;
        Integer lengthOflist = 0;
        Integer[] unass = new Integer[20];

        List<Auth> sonAuths;
        List<Auth> auths = new ArrayList();//所有待添加权限列表   去重后的
        for (Integer temp : unassignedPermission) {
            System.out.println(temp);//当前 权限ID
            auth = authService.queryAuthById(temp);//auth 当前待添加权限
            if (!auths.contains(auth))//每次需要添加节点时 同时判断其子节点 和 父节点 是否在待添加列表里
            {
                //待添加权限列表 没有该权限  需要添加
                unass[count++] = temp;//将待添加的节点 添加到 unass数组中
                auths.add(auth);
                lengthOflist++;

                //查询该权限所有子节点 并且添加进入 待添加权限列表
                sonAuths = authService.queryAllSonAuths(temp);
                for (Auth authtemp : sonAuths) {
                    //先判重？ 不重复则添加
                    if (!auths.contains(authtemp)) {
                        k = authtemp.getId();
                        unass[count] = k;//子节点ID添加入 待添加列表
                        count++;
                        lengthOflist++;
                        auths.add(authtemp);
                    }
                }
                //查询该节点 父节点是否存在  不在则添加
                parentAuth = authService.queryAuthById(auth.getAuthParentRoot());
                if (!auths.contains(parentAuth)) {
                    //添加其父节点
                    unass[count++] = parentAuth.getId();//父节点ID添加入 待添加列表
                    auths.add(parentAuth);
                    lengthOflist++;
                }
            }
        }
        Integer[] readyInsertPermission = new Integer[lengthOflist];
        for (int p = 0; p < lengthOflist; p++) {
            readyInsertPermission[p] = unass[p];
        }
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("roleId", roleId);
            map.put("permissionIds", readyInsertPermission);
            roleService.insertRolePermission(map);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
        }
        return result;
    }


    /**
     * 取消分配角色——对应页面 << 按钮
     */
    @ResponseBody
    @RequestMapping(value = "dounAssign")
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
        } catch (Exception e) {
            result.setSuccess(false);
        }
        return result;

    }

    //权限分配的 《《 取消分配按钮
    @ResponseBody
    @RequestMapping(value = "dounAssignPermission")
    public Object dounAssignPermission(Integer roleId, Integer[] assignedPermission) {
        Auth auth;
        List<Integer> authIds;
        List<Auth> allSonAuth;
        List<Auth> allSonAuthFromParent;
        List<Auth> auths = new ArrayList();//所有待删除权限列表   去重后的
        Integer count = 0;
        Integer tempint = 0;
        Integer lengthOfass = 0;
        Integer[] ass = new Integer[100];//创建ass保留所有要删除的权限ID assignedPermission
        for (Integer temp : assignedPermission) {
            //System.out.println(temp);//当前 权限ID
            auth = authService.queryAuthById(temp);//auth 当前待删除权限

            if (!auths.contains(auth) && auth.getAuthParentRoot() != 0)//非系统菜单 可删除&&没有添加过 可以添加入 删除列表
            {
                //删除自己本身
                ass[count++] = temp;
                lengthOfass++;
                auths.add(auth);
                //查找所有子节点，然后删除
                allSonAuth = authService.queryAllSonAuths(temp);
                for (Auth tempauth : allSonAuth) {
                    if (!auths.contains(tempauth)) {
                        ass[count++] = tempauth.getId();//将所有子节点 加入删除队列；
                        lengthOfass++;
                        auths.add(tempauth);
                    }
                }
                if (auths.contains(authService.queryAuthById(auth.getAuthParentRoot())) && auth.getAuthParentRoot() != 1) {//父节点是系统菜单不可删 &&父节点 已经 添加入删除列表  则不重复添加
                    //找出当前角色父节点的所有字节点  若只有 一个  则 肯定是当前 节点--》删除其父节点
                    //当前节点 父节点的 所有子节点
                    allSonAuthFromParent = authService.queryAllSonAuths(auth.getAuthParentRoot());
                    //查找 当前角色的所有权限  从所有权限中判断
                    authIds = authService.queryAuthIdsByRoleId(roleId);//当前角色的所有 权限ID
                    //遍历 查找 当前角色是否还有 自他兄弟节点
                    for (Auth tempauth2 : allSonAuthFromParent) {
                        if (authIds.contains(tempauth2.getId())) {
                            tempint++;
                        }
                    }
                    if (tempint <= 1) {//只能找到 这一个节点  则可以删除父节点
                        ass[count++] = auth.getAuthParentRoot();
                        lengthOfass++;
                        auths.add(authService.queryAuthById(auth.getAuthParentRoot()));
                    }
                }
            }
        }
        System.out.println("----------------------------------" + lengthOfass);
        Integer[] readyDeletePermission = new Integer[lengthOfass];
        for (int p = 0; p < lengthOfass; p++) {
            readyDeletePermission[p] = ass[p];
        }
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("roleId", roleId);
            map.put("permissionIds", readyDeletePermission);
            roleService.deleteRolePermission(map);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
        }
        return result;
    }

    /*
     * 删除用户
     * */
    @ResponseBody
    @RequestMapping(value = "deleteUser")
    public Object deleteUser(@RequestParam(value = "userId",required = false) Integer userId) {
        System.out.println("&&&&&&&&&&&&&&&");
        System.out.println("id_+_+_+_" + userId);
        AjaxResult result = new AjaxResult();
        try {
            userService.deleteUser(userId);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /**
     * 添加、修改用户信息
     *
     */
    @RequestMapping(value = "updateUser")
    public String updateUser(User user){
        //System.out.println(user);
        User result =  userService.queryUserById(user.getUserId());
        System.out.println("result"+result.getUserTrueName());
        if(result != null){
            userService.updateUser(user);
        }else{
            userService.insertUser(user);
        }
        return "redirect:index";
    }

    /*
    * 添加用户信息
    * */
    @RequestMapping(value = "addUser")
    public String addUser(User user,Model model){
        System.out.println("@@@"+user);
        String result = userService.validateLoginName(user.getUserName());
        System.out.println("%%%%"+result);
        if (result==""){
            userService.insertUser(user);
            System.out.println("$$$"+user);
            return "redirect:index";
        }
        else {
            System.out.println("失败");
            model.addAttribute("errormessage","账号名重复，添加失败");
            return "user/index";
        }
    }

}
