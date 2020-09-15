package com.ysu.service.impl;

import com.ysu.entity.User;
import com.ysu.repository.UserRepository;
import com.ysu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by 万恶de亚撒西 on 2020/9/14.
 */
@Service(value = "userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<User> queryAllUser() {
        return userRepository.queryAllUser();
    }

    @Override
    public User login(User user) {
        return userRepository.login(user);
    }

    @Override
    public User queryUserById(Integer id) {
        return userRepository.queryUserById(id);
    }

    @Override
    public List<Integer> queryRoleIdsByUserId(Integer id) {
        return userRepository.queryRoleIdsByUserId(id);
    }

    @Override
    public void insertUserRoles(Map<String, Object> map) {
        userRepository.insertUserRoles(map);
    }

    @Override
    public void deleteUserRoles(Map<String, Object> map) {
        userRepository.deleteUserRoles(map);
    }

}
