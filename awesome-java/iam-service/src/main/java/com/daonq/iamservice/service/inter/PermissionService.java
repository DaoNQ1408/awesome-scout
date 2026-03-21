package com.daonq.iamservice.service.inter;

import com.daonq.iamservice.dto.request.PermissionRequest;
import com.daonq.iamservice.dto.response.PermissionResponse;
import com.daonq.iamservice.entity.Permission;
import com.daonq.iamservice.enums.PermissionStatus;

import java.util.List;

public interface PermissionService {
    Permission getById(Long id);
    PermissionResponse getResponseById(Long id);
    List<PermissionResponse> getAll(PermissionStatus status);
    PermissionResponse create(PermissionRequest request);
    PermissionResponse update(Long id, PermissionRequest request);
    void delete(Long id);
}
