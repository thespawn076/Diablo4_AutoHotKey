; This script will press F1 when you press the 1 key,
; with a 0.5 second delay before F1 is sent,
; and will enforce a 15-second cooldown between F1 presses

#SingleInstance Force
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Initialize variables
global lastF1Press := 0

1::
    currentTime := A_TickCount
    timeSinceLastPress := (currentTime - lastF1Press) / 1000 ; Convert to seconds
    
    if (timeSinceLastPress >= 15 || lastF1Press = 0) {
        ; Show tooltip indicating F1 will be sent
        ToolTip, Sending F1 in 0.5 seconds...
        
        ; Wait 0.5 seconds before sending F1
        Sleep, 500
        
        ; Send F1 key
        Send, {F1}
        
        ; Update the timestamp
        lastF1Press := A_TickCount
        
        ; Update tooltip
        ToolTip, F1 pressed successfully
        SetTimer, RemoveToolTip, 1000
    } else {
        ; Calculate remaining time
        remainingTime := 15 - timeSinceLastPress
        
        ; Show a tooltip with the waiting message
        ToolTip, Please wait %remainingTime% seconds before pressing F1 again
        SetTimer, RemoveToolTip, 1000
    }
return

RemoveToolTip:
    ToolTip
    SetTimer, RemoveToolTip, Off
return