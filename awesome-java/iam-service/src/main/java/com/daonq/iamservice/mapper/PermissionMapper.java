package com.daonq.iamservice.mapper;

import com.daonq.iamservice.dto.request.PermissionRequest;
import com.daonq.iamservice.dto.response.PermissionResponse;
import com.daonq.iamservice.entity.Permission;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(
        componentModel = "spring",
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE
)
public interface PermissionMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "status", ignore = true)
    Permission toEntity(PermissionRequest permissionRequest);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "status", ignore = true)
    Permission updateEntity(PermissionRequest permissionRequest, @MappingTarget Permission permission);

    PermissionResponse toResponse(Permission permission);
}
