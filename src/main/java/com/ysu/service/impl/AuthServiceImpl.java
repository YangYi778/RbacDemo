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
        // TODO Auto-generated method stub
        return authRepository.queryAllAuths();
    }
    @Override
    public List<Auth> queryAuthByUser(User u) {
        return authRepository.queryAuthByUser(u);
    }
}
