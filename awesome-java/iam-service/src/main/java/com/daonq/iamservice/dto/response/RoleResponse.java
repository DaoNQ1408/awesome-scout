package com.daonq.iamservice.dto.response;

import com.daonq.iamservice.entity.Permission;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.Any;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RoleResponse {
    private Long id;
    private String name;
    private String description;
    private List<PermissionDto> permissions;

    public record PermissionDto(long id, String name) {
        public static PermissionDto from(Permission permission) {
            return new PermissionDto(
                    permission.getId(),
                    permission.getName()
            );
        }
    }
}
