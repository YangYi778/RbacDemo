package com.ysu.service;

import com.ysu.entity.Auth;
import com.ysu.entity.User;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
public interface AuthService {
    //根据父节点把所有子节点查出来
    public List<Auth> queryChildAuths(Integer id);

    public List<Auth> queryAllAuths();

    public List<Auth> queryAuthByUser(User u);

    /*
     * 添加权限
     * */
    public void insertAuth(Auth auth);

    /*
     * 编辑权限信息
     * */
    public void updateAuth(Auth auth);

    /*
     * 删除权限
     * */
    public void deleteAuth(int id);

    /*
    * 通过ID修改权限名
    * */
    public void updateAuthName(String name,int id);

    /*
     * 通过权限名来查权限
     * */
    public List<Auth> queryAuthByName(String name);


    public List<Integer> queryAuthIdsByRoleId(Integer id);

    public Auth queryAuthById(Integer id);

    public List<Auth> queryAllSonAuths(Integer id);
}
