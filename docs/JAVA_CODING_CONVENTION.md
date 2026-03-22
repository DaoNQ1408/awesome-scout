# Java Coding Convention & Style Guide

Tài liệu này quy định các tiêu chuẩn viết code áp dụng cho toàn bộ dự án Java. Việc tuân thủ nghiêm ngặt giúp mã nguồn đồng nhất, dễ đọc, dễ bảo trì và hạn chế tối đa bug tiềm ẩn.

## 1. Naming Convention (Quy tắc đặt tên)

Tuân thủ theo chuẩn gốc của Java:
* **Class / Interface / Enum:** Dùng `PascalCase` (VD: `UserProfile`, `ScoutService`, `RoleStatus`).
* **Method (Hàm) / Variable (Biến):** Dùng `camelCase` (VD: `getAllRoles()`, `scoutName`, `totalCount`).
* **Constant (Hằng số):** Dùng `UPPER_SNAKE_CASE` (VD: `MAX_LOGIN_RETRY`, `DEFAULT_ROLE`).
* **Package:** Viết thường toàn bộ, không dùng dấu gạch dưới (VD: `com.daonq.iamservice.controller`).
* **Định danh API:** Sử dụng danh từ, số nhiều, định dạng `kebab-case` (VD: `/api/v1/tour-schedules`).

## 2. Formatting & Spacing (Quy tắc khoảng trắng & Dòng trống)

Đây là các quy tắc **bắt buộc** để tạo ra "nhịp điệu" thống nhất khi đọc code từ trên xuống dưới.

### 2.1. Khai báo biến liên tục
* Tất cả các khai báo biến (biến toàn cục của class hoặc biến cục bộ đầu hàm) phải được viết **liên tục nhau, tuyệt đối không để dòng trắng xen kẽ**.
* Gom nhóm các biến có cùng mức độ truy cập (private/public) hoặc cùng logic lại với nhau.

### 2.2. Khoảng cách giữa Biến toàn cục và Hàm
* Phải có đúng **2 dòng trắng (2 blank lines)** ngăn cách giữa block khai báo biến toàn cục (fields/properties) cuối cùng và hàm (method/constructor) đầu tiên của class.

### 2.3. Khoảng cách giữa các Hàm
* Phải có đúng **2 dòng trắng (2 blank lines)** ngăn cách giữa điểm kết thúc của hàm trước và annotation/định nghĩa của hàm sau.

### 2.4. Khoảng cách giữa các Code Block trong Hàm
* Các khối logic khác nhau (if-else, vòng lặp, block tính toán, thao tác DB) trong cùng một hàm phải cách nhau đúng **1 dòng trắng (1 blank line)** để tạo sự rành mạch (chunking).

---

## 3. Code Example (Mẫu chuẩn)

Dưới đây là một class mẫu minh họa chính xác các quy tắc trên:

```java
package com.daonq.core.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ScoutProfileService {

    // ✅ QUY TẮC 2: Khai báo biến liên tục, không có dòng trắng xen kẽ
    private final ScoutRepository scoutRepository;
    private final TourValidationService tourValidationService;
    private final int maxAgeLimit = 18;
    private final String defaultRegion = "NORTH";


    // ✅ QUY TẮC 1: Biến toàn cục và Hàm đầu tiên cách nhau ĐÚNG 2 DÒNG TRẮNG
    public ScoutProfileResponse createScoutProfile(ScoutRequest request) {
        // ✅ QUY TẮC 2: Khai báo biến cục bộ liên tục
        String fullName = request.getFullName();
        int age = request.getAge();
        boolean isValidated = false;

        // ✅ QUY TẮC 3: Cách 1 dòng trắng trước khi chuyển sang logic block mới
        if (age > maxAgeLimit) {
            throw new InvalidScoutException("Độ tuổi vượt quá quy định.");
        }

        // ✅ QUY TẮC 3: Cách 1 dòng trắng giữa các khối xử lý logic
        isValidated = tourValidationService.validateRegion(defaultRegion);
        if (!isValidated) {
            throw new InvalidRegionException("Khu vực không hợp lệ.");
        }

        // ✅ QUY TẮC 3: Cách 1 dòng trắng trước khi thao tác Database
        ScoutProfile newProfile = new ScoutProfile(fullName, age, defaultRegion);
        scoutRepository.save(newProfile);

        // ✅ QUY TẮC 3: Cách 1 dòng trắng trước khi return
        return new ScoutProfileResponse(newProfile.getId(), "Tạo thành công");
    }


    // ✅ QUY TẮC 1: Các hàm cách nhau ĐÚNG 2 DÒNG TRẮNG
    public void deleteScoutProfile(Long id) {
        // Logic code tại đây...
    }
}
