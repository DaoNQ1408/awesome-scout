package com.daonq.iamservice.service.impl;

import com.daonq.iamservice.dto.request.RolePermissionRequest;
import com.daonq.iamservice.dto.request.RoleRequest;
import com.daonq.iamservice.dto.response.RoleResponse;
import com.daonq.iamservice.entity.Permission;
import com.daonq.iamservice.entity.Role;
import com.daonq.iamservice.enums.RoleStatus;
import com.daonq.iamservice.mapper.RoleMapper;
import com.daonq.iamservice.repository.RoleRepository;
import com.daonq.iamservice.service.inter.PermissionService;
import com.daonq.iamservice.service.inter.RoleService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RoleServiceImpl implements RoleService {

    RoleRepository roleRepository;
    RoleMapper roleMapper;
    PermissionService permissionService;


    @Override
    @Transactional(readOnly = true)
    public Role getById(Long id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Role not found with id: " + id));
    }


    @Override
    @Transactional(readOnly = true)
    public RoleResponse getResponseById(Long id) {
        Role role = getById(id);
        return roleMapper.toResponse(role);
    }


    @Override
    @Transactional(readOnly = true)
    public List<RoleResponse> getAll(RoleStatus status) {
        List<Role> roles = (status == null)
                ? roleRepository.findAll()
                : roleRepository.findByStatus(status);

        return roles.stream()
                .map(roleMapper::toResponse)
                .toList();
    }


    @Override
    @Transactional
    public RoleResponse create(RoleRequest request) {
        checkRoleNameUnique(request.getName());

        Role role = roleMapper.toEntity(request);
        Role result = roleRepository.save(role);

        return roleMapper.toResponse(result);
    }


    @Override
    @Transactional
    public RoleResponse update(Long id, RoleRequest request) {
        checkRoleNameUnique(request.getName());

        Role role = getById(id);

        Role updatedRole = roleMapper.updateEntity(request, role);
        Role result = roleRepository.save(updatedRole);

        return roleMapper.toResponse(result);
    }


    @Override
    @Transactional
    public RoleResponse mapRolePermissions(Long roleId, RolePermissionRequest request) {
        Role role = getById(roleId);
        List<Permission> permissions = permissionService.getAllByIds(request.getPermissionIds());

        if(permissions.size() != request.getPermissionIds().size()) {
            throw new RuntimeException("Some permissions not found with provided ids.");
        }

        role.setPermissions(permissions);
        roleRepository.save(role);

        return roleMapper.toResponse(role);
    }


    @Override
    @Transactional
    public void delete(Long id) {
        Role role = getById(id);

        role.setStatus(RoleStatus.DELETED);
        roleRepository.save(role);
    }


    private void checkRoleNameUnique(String name) {
        if(roleRepository.existsByName(name)) {
            throw new RuntimeException("Role with name '" + name + "' already exists.");
        }
    }
}
