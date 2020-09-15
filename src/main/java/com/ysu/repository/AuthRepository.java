package com.ysu.repository;

import com.ysu.entity.Auth;
import com.ysu.entity.User;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
public interface AuthRepository {

    public List<Auth> queryChildAuths(Integer id);

    public List<Auth> queryAllAuths();

    public List<Auth> queryAuthByUser(User u);
}
