package com.ysu.service.impl;

import com.ysu.entity.Role;
import com.ysu.repository.RoleRepository;
import com.ysu.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

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

    @Override
    public void insertRolePermission(Map<String, Object> map) {
        roleRepository.insertRolePermission(map);
    }

    @Override
    public void deleteRolePermission(Map<String, Object> map) {
        roleRepository.deleteRolePermission(map);
    }

    @Override
    public Role queryRoleById(Integer id) {
        return roleRepository.queryRoleById(id);
    }
}
