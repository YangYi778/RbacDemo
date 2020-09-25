package com.ysu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ysu.entity.AjaxResult;
import com.ysu.entity.Auth;
import com.ysu.entity.Role;
import com.ysu.entity.User;
import com.ysu.service.AuthService;
import com.ysu.service.RoleService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
@Controller
@RequestMapping(value = "/permission")
public class PermissionController {
    @Autowired
    private AuthService authService;

    @Autowired
    private RoleService roleService;

    @RequestMapping(value="authIndex")
    public String authIndex(HttpServletRequest request) {
        List<Auth> auths = authService.queryAllAuths();
        for(Auth auth: auths) {
            System.out.println(auth);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        request.getSession().setAttribute("auths", auths);
        return "permission/authIndex";
    }

    /**
     * 角色维护首页——用于展示当前已存在的角色信息列表
     * @param pn
     * @param model
     * @return
     */
    @RequestMapping(value="roleIndex")
    public String roleIndex(@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,5);
        List<Role> roles = roleService.queryAllRole();
        for(Role role: roles) {
            System.out.println(role);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(roles, 6);
        model.addAttribute("pageInfo",page);
        return "permission/roleIndex";
    }

    /**
     * 加载菜单树——测试使用
     * @return
     */
    @ResponseBody
    @RequestMapping(value="loadData")
    public Object loadData() {
        System.out.println("loadData>>>>>>>>>>>");
        //双循环
        List<Auth> authList = new ArrayList<Auth>();
        List<Auth> auths = authService.queryAllAuths();
        for(Auth auth : auths) {
            //每一个结点都当做它的子节点
            Auth child = auth;
            //然后查找它的父节点，等零表示没有父节点
            if(auth.getAuthParentRoot() == 0) {
                authList.add(auth);
            }else {
                for(Auth innerAuth : auths) {
                    if(child.getAuthParentRoot().equals(innerAuth.getId())) {
                        //父节点
                        Auth parent = innerAuth;
                        //组合父子节点的关系
                        parent.getChildren().add(child);
                        break;
                    }
                }
            }
        }
        return authList;

    }
    //递归查询权限信息——效率低
    public void queryChildAuths(Auth parent) {
        List<Auth> childAuths = authService.queryChildAuths(parent.getId());
        for(Auth auth : childAuths) {
            queryChildAuths(auth);
        }
        parent.setChildren(childAuths);
    }

    /*通过id修改权限名称*/
    @ResponseBody
    @RequestMapping(value="updateAuthName")
    public void updateAuthName(HttpServletRequest request,@RequestParam(value = "name",required=false)String name,@RequestParam(value = "id",required=false)int id){
        try {
            authService.updateAuthName(name,id);
        }catch (Exception e){
            e.printStackTrace();
        }
        List<Auth> auths = authService.queryAllAuths();
        request.getSession().setAttribute("auths", auths);
    }

    /*删除权限*/
    @ResponseBody
    @RequestMapping(value = "deleteAuth")
    public Object deleteAuth(HttpServletRequest request){
        AjaxResult result = new AjaxResult();
        String[] ids = request.getParameterValues("ids[]");
        try {
            for(String id : ids){
                System.out.println(Integer.parseInt(id));
                authService.deleteAuth(Integer.parseInt(id));
            }
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    /*添加权限*/
    @ResponseBody
    @RequestMapping(value = "addAuth")
    public  Object addAuth(Auth auth){
        AjaxResult result = new AjaxResult();	//ajax返回的对象
        List<Auth> auths = authService.queryAuthByName(auth.getName());
        if(auths.size()==0){
            try {
                result.setSuccess(true);
                authService.insertAuth(auth);
            }catch (Exception e){
                result.setSuccess(false);
            }
        }
        return result;
    }
}
