#Persistent
SetTimer, CheckForErrors, 1000  ; Check every second
return

; List of EXCLUDED window classes or executable names (case-insensitive)
ExcludedClasses := ["Notepad", "Chrome_WidgetWin_1"]
ExcludedExeNames := ["notepad.exe", "code.exe"]

CheckForErrors:
{
    WinGet, id, List,,, Program Manager

    Loop, %id%
    {
        this_id := id%A_Index%

        ; Get details about the window
        WinGetTitle, title, ahk_id %this_id%
        WinGetClass, class, ahk_id %this_id%
        WinGet, exePath, ProcessPath, ahk_id %this_id%
        SplitPath, exePath, exeName

        ; Skip if it's on the excluded list
        if (ExeIsExcluded(exeName) or ClassIsExcluded(class))
            continue

        ; Check for error-like titles/classes
        if (InStr(title, "error") or InStr(class, "Error"))
        {
            ; Move the window far off-screen
            WinMove, ahk_id %this_id%, , 5000, 5000
        }
    }
}

ExeIsExcluded(name) {
    global ExcludedExeNames
    for _, exe in ExcludedExeNames
        if (StrLower(name) = StrLower(exe))
            return true
    return false
}

ClassIsExcluded(class) {
    global ExcludedClasses
    for _, cls in ExcludedClasses
        if (StrLower(class) = StrLower(cls))
            return true
    return false
}
