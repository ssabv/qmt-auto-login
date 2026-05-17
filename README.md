# 国金证券 QMT 自动登录脚本

自动登录国金证券 QMT 交易端的 AutoHotkey 脚本，支持定时执行。

## 功能

- 自动关闭残留 QMT 进程
- 以管理员权限启动 QMT
- 等待窗口加载完成（30秒强制等待）
- 自动填写账号密码并回车登录
- 可配合定时工具实现每周/每日自动运行

## 使用方法

### 1. 安装 AutoHotkey v2

下载地址：https://github.com/AutoHotkey/AutoHotkey

### 2. 下载脚本

下载 `qmt_auto_login.ahk` 到本地。

### 3. 修改配置

用记事本打开脚本，修改以下配置：

```ahk
global QMT_PATH  := "D:\国金证券QMT交易端\bin.x64\XtItClient.exe"   ; 程序路径
global USERNAME  := "123456"   ; 你的账号
global PASSWORD  := "123456"   ; 你的密码
```

### 4. 运行

双击 `qmt_auto_login.ahk` 即可运行。

## 定时运行（可选）

如果需要定时自动运行（比如每周日 10 点），使用 **WeeklyRunner**：

- 下载地址：https://github.com/ssabv/weekly-runner/releases/download/v1.0.0/WeeklyRunner.exe
- 仓库地址：https://github.com/ssabv/weekly-runner

设置步骤：
1. 打开 WeeklyRunner.exe
2. 浏览选择 `qmt_auto_login.ahk`
3. 设置执行时间和星期几
4. 点击"启动"
5. 最小化到托盘后台运行

## 视频教程

【qmt自动登录工具免费分享-哔哩哔哩】 https://b23.tv/0zxutli

## 相关链接

| 工具 | 链接 |
|------|------|
| AutoHotkey v2 | https://github.com/AutoHotkey/AutoHotkey |
| WeeklyRunner（定时工具） | https://github.com/ssabv/weekly-runner |
| 视频教程 | https://b23.tv/0zxutli |

## 注意事项

- 需要 **AutoHotkey v2**（脚本第一行有 `#Requires AutoHotkey v2.0`）
- 需要以 **管理员权限** 运行（脚本会自动请求）
- 30 秒强制等待是为了等 QMT 窗口完全加载，避免输入失败
- 脚本使用 `BlockInput` 锁定键鼠，运行期间请勿操作电脑
