package com.daonq.iamservice.mapper;

import com.daonq.iamservice.dto.request.RoleRequest;
import com.daonq.iamservice.dto.response.RoleResponse;
import com.daonq.iamservice.entity.Permission;
import com.daonq.iamservice.entity.Role;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

import java.util.List;

@Mapper(
        componentModel = "spring",
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE
)
public interface RoleMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "permissions", ignore = true)
    @Mapping(target = "employees", ignore = true)
    @Mapping(target = "permissions", ignore = true)
    Role toEntity(RoleRequest roleRequest);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "permissions", ignore = true)
    @Mapping(target = "employees", ignore = true)
    @Mapping(target = "permissions", ignore = true)
    Role updateEntity(RoleRequest roleRequest, @MappingTarget Role role);

    @Mapping(target = "permissions", expression = "java(toPermissionDtoList(role.getPermissions()))")
    RoleResponse toResponse(Role role);

    List<RoleResponse.PermissionDto> toPermissionDtoList(List<Permission> permissions);
}
