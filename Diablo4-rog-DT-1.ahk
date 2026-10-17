; Diablo 4 Hotkey Script
; Hold button 1 to spam buttons 2, 3, and 4 every 0.5 seconds
; Make sure Diablo 4 is the active window for this to work properly

#NoEnv
#SingleInstance Force
#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%

; Variables
spamming := false
spamTimer := 500  ; 0.5 seconds in milliseconds

; Function to send keys 2, 3, 4
SpamKeys() {
    if (spamming) {
        Send, 2
        Sleep, 50  ; Small delay between key presses
        Send, 3
        Sleep, 50
        Send, 4
        ; Schedule next spam cycle
        SetTimer, SpamKeys, %spamTimer%
    }
}

; Alternative approach using GetKeyState
CheckKey1() {
    if (GetKeyState("1", "P")) {
        if (!spamming) {
            spamming := true
            Send, 1  ; Send the initial button 1 press
            SetTimer, SpamKeys, %spamTimer%
        }
    } else {
        if (spamming) {
            spamming := false
            SetTimer, SpamKeys, Off
        }
    }
}

; Check key state every 10ms
SetTimer, CheckKey1, 10

; Remove the hotkey definitions
; *1::
;     spamming := true
;     Send, 1  ; Send the initial button 1 press
;     SetTimer, SpamKeys, %spamTimer%
;     KeyWait, 1  ; Wait until key 1 is released
;     spamming := false
;     SetTimer, SpamKeys, Off
; return

; Optional: ESC key to emergency stop the script
Esc::
    spamming := false
    SetTimer, SpamKeys, Off
    MsgBox, Script stopped. Press Ctrl+R to reload or close this window.
return

; Optional: Ctrl+R to reload the script
^r::Reload