package com.ysu.repository;

import com.ysu.entity.Auth;
import com.ysu.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
public interface AuthRepository {

    /*
    * 添加权限
    * */
    public void insertAuth(Auth auth);

    /*
    * 编辑权限信息
    * */
    public void updateAuth(Auth auth);

    /*
    * 通过id删除权限
    * */
    public void deleteAuth(int id);

    /*
    * 查询子权限
    * */
    public List<Auth> queryChildAuths(Integer id);

    /*
    * 查询所有权限
    * */
    public List<Auth> queryAllAuths();

    /*
    * 查用户权限
    * */
    public List<Auth> queryAuthByUser(User u);

    /*
     * 通过ID修改权限名
     * */
    public void updateAuthName(@Param("name") String name,@Param("id") int id);

    /*
    * 通过权限名来查权限
    * */
    public List<Auth> queryAuthByName(String name);
}
