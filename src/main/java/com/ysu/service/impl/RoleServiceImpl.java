package com.ysu.service.impl;

import com.ysu.entity.Role;
import com.ysu.repository.RoleRepository;
import com.ysu.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
@Service(value = "roleService")
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleRepository roleRepository;

    @Override
    public List<Role> queryAllRole() {
        return roleRepository.queryAllRole();
    }
}
