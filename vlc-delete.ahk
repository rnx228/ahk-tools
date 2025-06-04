; List of parent folders to search
parentFolders := ["D:\Videos", "F:\video"]  ; <--- Edit these paths

~MButton::
clickStart := A_TickCount

; Wait briefly to check if the button is held
KeyWait, MButton, T0.3  ; Wait up to 0.3 seconds for release
if (ErrorLevel)  ; If still held after 0.3s, do nothing
    return

clickDuration := A_TickCount - clickStart
if (clickDuration > 299)
    return  ; Held too long, don't proceed

; Get VLC window title
WinGetTitle, winTitle, A
if !InStr(winTitle, "VLC media player")
    return  ; Not VLC window

; Extract filename from window title
fileName := RegExReplace(winTitle, " - VLC media player.*", "")
fileName := Trim(fileName)
StringLower, fileNameLower, fileName

fileFound := ""

; Search in defined parent folders
for index, parent in parentFolders
{
    Loop, Files, %parent%\*.*, R
    {
        StringLower, loopFileLower, A_LoopFileName
        if (loopFileLower = fileNameLower)
        {
            fileFound := A_LoopFileFullPath
            break
        }
    }
    if (fileFound != "")
        break
}

if (fileFound = "")
    return  ; File not found

; Stop playback in VLC
WinActivate, ahk_exe vlc.exe
WinWaitActive, ahk_exe vlc.exe,, 2
SendInput, s
Sleep, 400

; Move file to Recycle Bin
FileRecycle, %fileFound%
return
