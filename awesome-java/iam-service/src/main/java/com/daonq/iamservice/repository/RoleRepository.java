package com.daonq.iamservice.repository;

import com.daonq.iamservice.entity.Role;
import com.daonq.iamservice.enums.RoleStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoleRepository extends JpaRepository<Role,Long> {
    boolean existsByName(String name);

    List<Role> findByStatus(RoleStatus status);
}
