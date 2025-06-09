#Persistent
SetTimer, CheckForGameErrors, 1000
return

CheckForGameErrors:
    WinGet, id, List,,, Program Manager

    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, title, ahk_id %this_id%

        ; Only check windows with title "Error"
        if (title != "Error")
            continue

        WinGetText, text, ahk_id %this_id%

        ; Match GF2 or Wuthering Waves error content
        if (InStr(text, "GIRLS' FRONTLINE 2 EXILIUM")
         || InStr(text, "GF2_Exilium_Data")
         || InStr(text, "Wuthering Waves")
         || InStr(text, "Client-Win64-Shipping.exe"))
        {
            WinMove, ahk_id %this_id%, , 5000, 5000
        }
    }
return
