package com.ysu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ysu.entity.Auth;
import com.ysu.entity.Role;
import com.ysu.entity.User;
import com.ysu.service.AuthService;
import com.ysu.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public String authIndex(@RequestParam(value="pn", defaultValue="1")Integer pn, Model model) {
        //传入当前页，以及页面的大小
        PageHelper.startPage(pn,1);
        List<Auth> auths = authService.queryAllAuths();
        for(Auth auth: auths) {
            System.out.println(auth);
        }
        //pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //封装了分页的信息,6表示底部连续显示的页数
        PageInfo page = new PageInfo(auths, 6);
        model.addAttribute("pageInfo",page);
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
        PageHelper.startPage(pn,1);
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
		/*List<Auth> auths = new ArrayList();
		Auth root = new Auth();
		root.setName("顶级结点");
		Auth child = new Auth();
		child.setName("子节点");
		root.getChildren().add(child);
		auths.add(root);
		return auths;*/

		/*递归调用
		 * Auth parent = new Auth();
		parent.setId(0);		//顶层父节点
		queryChildAuths(parent);
		return parent.getChildren();*/

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
}
