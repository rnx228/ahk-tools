#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


~4:: ;hotkey triger loop
Loop
{
    Sleep, 20
 Send, {ClickLeft}
 Sleep, 18
    Send {g}
    Sleep, 18
 Send {g}
 
 if (GetKeyState("4", "P") or GetKeyState("Shift", "P") or GetKeyState("Space", "P")) ;hotkey buat hentiin loop
 Break
}
return
