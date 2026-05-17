; ==============================================================================
; 国金证券 QMT 自动登录脚本 (精准识别版)
; 适用版本: 2.0.8.300 | 窗口类名: Qt5QWindowIcon
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn All, Off 

; ---------- 核心配置区 ----------
global QMT_PATH  := "D:\国金证券QMT交易端\bin.x64\XtItClient.exe"   ; 程序路径自己填
global USERNAME  := "123456"   ; 账号自己填
global PASSWORD  := "123456"   ; 密码自己填
; 精准窗口识别特征
global QMT_CLASS := "ahk_class Qt5QWindowIcon"  ; 自己抓 国金不用管 理论所有程序都可以
global QMT_EXE   := "ahk_exe XtItClient.exe"   ; 自己抓 国金不用管 理论所有程序都可以
global QMT_TITLE := QMT_CLASS . " " . QMT_EXE   ; 不用管

; 强制等待时间：30秒
global FORCE_WAIT_MS := 30000 
; ------------------------------

; 1. 环境清理：确保没有残留进程
if ProcessExist("XtItClient.exe") {
    ProcessClose("XtItClient.exe")
    Sleep(2000)
}

; 2. 以管理员权限启动 QMT
try {
    Run(QMT_PATH, "", "runas")
} catch Error as e {
    MsgBox("启动失败！请检查路径是否正确：`n" . QMT_PATH)
    ExitApp()
}

; 3. 等待窗口初步加载
; 只要检测到窗口类名 Qt5QWindowIcon 出现，立即启动 30 秒计时
if !WinWait(QMT_TITLE, , 30) {
    MsgBox("❌ QMT 窗口在 30 秒内未启动，流程终止。")
    ExitApp()
}

; 4. 【强制等待】精准 30 秒倒计时
startTime := A_TickCount
while (A_TickCount - startTime < FORCE_WAIT_MS) {
    remaining := Ceil((FORCE_WAIT_MS - (A_TickCount - startTime)) / 1000)
    ToolTip("已识别 QMT 窗口，强制等待中... 剩余 " . remaining . " 秒开始输入")
    Sleep(100)
}
ToolTip() ; 清除倒计时

; 5. 精准激活并执行登录
if WinExist(QMT_TITLE) {
    ; 强制置顶并激活
    WinActivate(QMT_TITLE)
    if !WinWaitActive(QMT_TITLE, , 5) {
        ToolTip("无法激活 QMT 窗口，请手动点击窗口")
        Sleep(2000)
        ToolTip()
    }
    
    ; 锁定键鼠，确保输入不被干扰
    BlockInput(true)
    
    ; --- 填写账号 ---
    ; 针对 Qt 界面，全选后 Backspace 是最稳妥的清理方式
    Send("^a{Backspace}") 
    Sleep(2000)
    SendText(USERNAME)
    Sleep(2000)
    
    ; --- 切换到密码框 ---
    Send("{Tab}")
    Sleep(2000)
    
    ; --- 填写密码 ---
    Send("^a{Backspace}")
    Sleep(2000)
    SendText(PASSWORD)
    Sleep(2000)
    
    ; --- 回车登录 ---
    Send("{Enter}")
    
    BlockInput(false) ; 解锁键鼠
}

; 6. 任务完成
ToolTip("✅ 30秒强制等待结束，登录流程已完成")
SetTimer () => ToolTip(), -5000

; 脚本保持运行。若需登录后自动退出，取消下方注释
; ExitApp()