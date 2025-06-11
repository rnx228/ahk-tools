#Persistent
SetTimer, CheckForGameErrors, 1000
return

CheckForGameErrors:
    WinGet, id, List

    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, title, ahk_id %this_id%
        WinGetText, text, ahk_id %this_id%

        ; Check if it's an error window and matches known error text
        if ((title = "Error" or InStr(title, "GIRLS' FRONTLINE 2 EXILIUM") or InStr(title, "Wuthering Waves") or InStr(title, "Client-Win64-Shipping.exe"))
        or (InStr(text, "GF2_Exilium_Data")))
        {
            ; Move the error window offscreen
            WinMove, ahk_id %this_id%, , 5000, 5000
        }
    }
return
