package com.daonq.iamservice.service.impl;

import com.daonq.iamservice.dto.request.PermissionRequest;
import com.daonq.iamservice.dto.response.PermissionResponse;
import com.daonq.iamservice.entity.Permission;
import com.daonq.iamservice.enums.PermissionStatus;
import com.daonq.iamservice.mapper.PermissionMapper;
import com.daonq.iamservice.repository.PermissionRepository;
import com.daonq.iamservice.service.inter.PermissionService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PermissionServiceImpl implements PermissionService {

    PermissionRepository permissionRepository;
    PermissionMapper permissionMapper;


    @Override
    @Transactional(readOnly = true)
    public Permission getById(Long id) {
        return permissionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Permission not found with id: " + id));
    }


    @Override
    @Transactional(readOnly = true)
    public PermissionResponse getResponseById(Long id) {
        Permission permission = getById(id);
        return permissionMapper.toResponse(permission);
    }


    @Override
    @Transactional(readOnly = true)
    public List<PermissionResponse> getAll(PermissionStatus status) {
        List<Permission> permissions = (status == null)
                ? permissionRepository.findAll()
                : permissionRepository.findByStatus(status);

        return permissions.stream()
                .map(permissionMapper::toResponse)
                .toList();
    }


    @Override
    @Transactional
    public PermissionResponse create(PermissionRequest request) {
        checkPermissionNameUnique(request.getName());

        Permission permission = permissionMapper.toEntity(request);
        Permission result = permissionRepository.save(permission);

        return permissionMapper.toResponse(result);
    }


    @Override
    @Transactional
    public PermissionResponse update(Long id, PermissionRequest request) {
        checkPermissionNameUnique(request.getName());

        Permission permission = getById(id);

        Permission updatedPermission = permissionMapper.updateEntity(request, permission);
        Permission result = permissionRepository.save(updatedPermission);

        return permissionMapper.toResponse(result);
    }


    @Override
    @Transactional
    public void delete(Long id) {
        Permission permission = getById(id);

        permission.setStatus(PermissionStatus.DELETED);
        permissionRepository.save(permission);
    }


    private void checkPermissionNameUnique(String name) {
        if(permissionRepository.existsByName(name)) {
            throw new RuntimeException("Permission with name '" + name + "' already exists.");
        }
    }
}
