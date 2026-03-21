package com.daonq.iamservice.repository;

import com.daonq.iamservice.entity.Permission;
import com.daonq.iamservice.enums.PermissionStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface PermissionRepository extends JpaRepository<Permission,Long> {
    List<Permission> findByStatus(PermissionStatus status);

    Permission findByName(String name);

    boolean existsByName(String name);
}
