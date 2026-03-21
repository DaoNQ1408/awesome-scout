# 📌 Commit Convention Guide

This project follows the **Conventional Commits** standard to keep commit history clean, readable, and scalable.

---

## 🚀 Commit Message Format

```
<type>(optional scope): <short description>
```

### ✅ Example

```
feat(auth): add Google login
fix(role): handle null permission
refactor(user): simplify service logic
```

---

## 📂 Commit Types

| Type       | Description                       |
| ---------- | --------------------------------- |
| `feat`     | Add a new feature                 |
| `fix`      | Fix a bug                         |
| `docs`     | Documentation changes             |
| `style`    | Code formatting (no logic change) |
| `refactor` | Code refactoring                  |
| `test`     | Add or update tests               |
| `chore`    | Build/config/dependencies         |
| `perf`     | Performance improvements          |
| `ci`       | CI/CD configuration               |

---

## 🎯 Scope (Optional but Recommended)

Scope indicates the module affected:

```
feat(auth): ...
fix(role): ...
refactor(permission): ...
```

---

## ✨ Writing Rules

* Use **present tense**
* Keep it **short and clear**
* Do **not capitalize first letter** (recommended)
* Do **not end with a period**

### ❌ Bad

```
Added login API.
Fix bug.
```

### ✅ Good

```
add login API
fix null pointer in user service
```

---

## 🔥 Commit with Body

```
feat(role): add permission assignment API

- create RolePermissionRequest
- update role mapper
- add service logic
```

---

## 🧠 Best Practices

* Keep commits **small and focused**
* One commit = one purpose
* Avoid mixing multiple features in one commit
* Use meaningful messages (not "update", "fix stuff")

---

## ✅ Quick Examples

```
feat(role): add assign permissions API
fix(permission): default status when null
refactor(role): clean mapper logic
chore(docker): add nginx config
```

---

Happy coding 🚀
#### © 2026 DaoNQ
