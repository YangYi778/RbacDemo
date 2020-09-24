package com.ysu.repository;

import com.ysu.entity.Role;

import java.util.List;
import java.util.Map;

/**
 * Created by 万恶de亚撒西 on 2020/9/15.
 */
public interface RoleRepository {

    public List<Role> queryAllRole();

    public void insertRolePermission(Map<String, Object> map);

    public void deleteRolePermission(Map<String, Object> map);

    public Role queryRoleById(Integer id);
}
