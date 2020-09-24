package com.ysu.service.impl;

import com.ysu.entity.Auth;
import com.ysu.entity.User;
import com.ysu.repository.AuthRepository;
import com.ysu.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
@Service(value = "authService")
public class AuthServiceImpl implements AuthService {
    @Autowired
    private AuthRepository authRepository;


    @Override
    public List<Auth> queryChildAuths(Integer id) {
        return authRepository.queryChildAuths(id);
    }
    @Override
    public List<Auth> queryAllAuths() {
        return authRepository.queryAllAuths();
    }
    @Override
    public List<Auth> queryAuthByUser(User u) {
        return authRepository.queryAuthByUser(u);
    }

    @Override
    public void insertAuth(Auth auth) {
        authRepository.insertAuth(auth);
    }

    @Override
    public void updateAuth(Auth auth) {
        authRepository.updateAuth(auth);
    }

    @Override
    public void deleteAuth(int id) {
        authRepository.deleteAuth(id);
    }

    @Override
    public void updateAuthName(String name, int id) {
        authRepository.updateAuthName(name,id);
    }

    @Override
    public List<Auth> queryAuthByName(String name) {
        List<Auth> auths = authRepository.queryAuthByName(name);
        return auths;
    }

    @Override
    public List<Auth> queryAllSonAuths(Integer id) {
        return authRepository.queryAllSonAuths(id);
    }

    @Override
    public Auth queryAuthById(Integer id) {
        return authRepository.queryAuthById(id);
    }

    @Override
    public List<Integer> queryAuthIdsByRoleId(Integer id) {
        return authRepository.queryAuthIdsByRoleId(id);
    }
}
