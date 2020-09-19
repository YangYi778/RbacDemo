package com.ysu.service;

import com.ysu.entity.User;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by 万恶de亚撒西 on 2020/9/14.
 */
public interface UserService {

    public List<User> queryAllUser();

    public User queryUserById(Integer id);

    public List<Integer> queryRoleIdsByUserId(Integer id);

    public void insertUserRoles(Map<String, Object> map);

    public void deleteUserRoles(Map<String, Object> map);


    /*
     * 登录
     * */
    public User login(User user);

    /*
     * 验证是否已占用
     * */
    public String validateLoginName(String userName);

    /*
     * 保存用户信息
     * */
    public void saveUser(User user, HttpServletRequest request);

    /*
     * 更新激活码
     * */
    public  String active(String activeCode);

    /*
     * 根据激活码获取用户信息,如果找不到说明激活码不正确,或者巳经激活过
     * */
    User getUserByActive(String activeCode);

}
