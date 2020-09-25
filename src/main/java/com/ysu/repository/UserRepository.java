package com.ysu.repository;

import com.ysu.entity.User;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * Created by 万恶de亚撒西 on 2020/9/14.
 */
public interface UserRepository {

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
    * 验证用户名是否已占用
    * */
    public String validateLoginName(String userName);

    /*
    * 保存用户信息
    * */
    public void saveUser(User user);

    /*
    * 更新激活码
    * */
    public  void active(String activeCode);

    /*
    * 根据激活码获取用户信息,如果找不到说明激活码不正确,或者巳经激活过
    * */
    public User getUserByActive(String activeCode);


    /*
     * 添加用户
     * */
    public void insertUser(User user);

    /*
     * 更新用户
     * */
    public void updateUser(User user);

    /*
     * 删除用户
     * */
    public void deleteUser(Integer userId);
}
