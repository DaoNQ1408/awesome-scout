package com.daonq.iamservice.controller;

import com.daonq.iamservice.dto.request.PermissionRequest;
import com.daonq.iamservice.dto.response.PermissionResponse;
import com.daonq.iamservice.enums.PermissionStatus;
import com.daonq.iamservice.service.inter.PermissionService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/permissions")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PermissionController {

    PermissionService permissionService;


    @GetMapping("/{id}")
    public ResponseEntity<PermissionResponse> get(@PathVariable Long id) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(permissionService.getResponseById(id));
    }


    @GetMapping()
    public ResponseEntity<List<PermissionResponse>> getAll(
            @RequestParam(value = "status", required = false) PermissionStatus status
    ) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(permissionService.getAll(status));
    }


    @PostMapping()
    public ResponseEntity<PermissionResponse> create(
            @RequestBody PermissionRequest permissionRequest
    ) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(permissionService.create(permissionRequest));
    }


    @PutMapping("/{id}")
    public ResponseEntity<PermissionResponse> update(
            @PathVariable Long id,
            @RequestBody PermissionRequest permissionRequest
    ) {
        return  ResponseEntity
                .status(HttpStatus.OK)
                .body(permissionService.update(id, permissionRequest));
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) {
        permissionService.delete(id);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body("Deleted permission " + id);
    }
}
