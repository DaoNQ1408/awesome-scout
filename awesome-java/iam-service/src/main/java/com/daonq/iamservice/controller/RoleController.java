package com.daonq.iamservice.controller;

import com.daonq.iamservice.dto.request.RolePermissionRequest;
import com.daonq.iamservice.dto.request.RoleRequest;
import com.daonq.iamservice.dto.response.RoleResponse;
import com.daonq.iamservice.enums.RoleStatus;
import com.daonq.iamservice.service.inter.RoleService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/roles")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RoleController {

    RoleService roleService;


    @GetMapping("/{id}")
    public ResponseEntity<RoleResponse> get(@PathVariable Long id) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(roleService.getResponseById(id));
    }


    @GetMapping()
    public ResponseEntity<List<RoleResponse>> getAll(
            @RequestParam(value = "status", required = false) RoleStatus status
    ) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(roleService.getAll(status));
    }


    @PostMapping()
    public ResponseEntity<RoleResponse> create(
            @RequestBody RoleRequest request
    ) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(roleService.create(request));
    }


    @PutMapping("/{id}")
    public ResponseEntity<RoleResponse> update(
            @PathVariable Long id,
            @RequestBody RoleRequest request
    ) {
        return  ResponseEntity
                .status(HttpStatus.OK)
                .body(roleService.update(id, request));
    }


    @PutMapping("/{id}/permissions")
    public ResponseEntity<RoleResponse> mapRolePermissions(
            @PathVariable Long id,
            @RequestBody RolePermissionRequest request
    ) {
        return  ResponseEntity
                .status(HttpStatus.OK)
                .body(roleService.mapRolePermissions(id, request));
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) {
        roleService.delete(id);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body("Deleted role " + id);
    }
}
