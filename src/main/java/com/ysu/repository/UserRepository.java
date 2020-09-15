package com.ysu.repository;

import com.ysu.entity.User;

import java.util.List;
import java.util.Map;

/**
 * Created by 万恶de亚撒西 on 2020/9/14.
 */
public interface UserRepository {

    public List<User> queryAllUser();

    public User login(User user);

    public User queryUserById(Integer id);

    public List<Integer> queryRoleIdsByUserId(Integer id);

    public void insertUserRoles(Map<String, Object> map);

    public void deleteUserRoles(Map<String, Object> map);
}
