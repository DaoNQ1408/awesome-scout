package com.daonq.iamservice.service.inter;

import com.daonq.iamservice.dto.request.RolePermissionRequest;
import com.daonq.iamservice.dto.request.RoleRequest;
import com.daonq.iamservice.dto.response.RoleResponse;
import com.daonq.iamservice.entity.Role;
import com.daonq.iamservice.enums.RoleStatus;

import java.util.List;

public interface RoleService {
    Role getById(Long id);
    RoleResponse getResponseById(Long id);
    List<RoleResponse> getAll(RoleStatus status);
    RoleResponse create(RoleRequest request);
    RoleResponse update(Long id, RoleRequest request);
    RoleResponse mapRolePermissions(Long roleId, RolePermissionRequest request);
    void delete(Long id);
}
