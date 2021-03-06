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
}
