---
title: cursor修machine id
categories: work
---

## 手动配置方法

1. 完全关闭 Cursor
2. 找到配置文件位置：

    - Windows: %APPDATA%\Cursor\User\globalStorage\storage.json
    - macOS: ~/Library/Application Support/Cursor/User/globalStorage/storage.json
    - Linux: ~/.config/Cursor/User/globalStorage/storage.json

3. 备份 storage.json
4. 编辑 storage.json 并更新以下字段（使用新的随机UUID）：
```json
{
  "telemetry.machineId": "生成新的uuid",
  "telemetry.macMachineId": "生成新的uuid",
  "telemetry.devDeviceId": "生成新的uuid",
  "telemetry.sqmId": "生成新的uuid",
  "lastModified": "2024-01-01T00:00:00.000Z",
  "version": "1.0.1"
}
```
5. 保存文件并重启 Cursor