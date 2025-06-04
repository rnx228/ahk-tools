#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; === Volume Control with Right Click + Scroll ===
~RButton & WheelUp::SoundSet, +2
~RButton & WheelDown::SoundSet, -2

; === Ctrl+Shift+T on holding Left and Right buttons simultaneously for 1 second ===

; Define a custom hotkey for pressing both buttons together
~LButton & RButton::
    KeyWait, RButton, T0.2  ; Wait up to 1 second for RButton to be released
    if (ErrorLevel = 0)
        return  ; Released too early, do nothing
    ; If here, RButton was held for 1 second together with LButton
    Send ^+t
return

; The opposite combo, in case pressing right then left
~RButton & LButton::
    KeyWait, LButton, T0.2
    if (ErrorLevel = 0)
        return
    Send ^+t
return

; === Middle mouse button hold detection ===
mHoldTimerActive := false

~MButton::
    SetTimer, MiddleHoldCheck, -250
    mHoldTimerActive := true
return

~MButton Up::
    SetTimer, MiddleHoldCheck, Off
    mHoldTimerActive := false
return

MiddleHoldCheck:
if (GetKeyState("MButton", "P")) {
    Send {LWin}
}
mHoldTimerActive := false
return
