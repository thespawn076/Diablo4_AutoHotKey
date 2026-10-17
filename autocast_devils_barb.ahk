; AutoHotkey Script: Right Click Hold + Left Click Sequence
; Hold right mouse button and left click to press keys 1,2,3,4 with 50ms delays

#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Variable to track if right mouse button is held down
RButtonHeld := false

; Right mouse button down event
~RButton::
    RButtonHeld := true
return

; Right mouse button up event  
~RButton Up::
    RButtonHeld := false
return

; Left click while right button is held
~LButton::
    if (RButtonHeld) {
        ; Send keys 1, 2, 3, 4 with 50ms delays
        Send, 1
        Sleep, 50
        Send, 2
        Sleep, 50
        Send, 3
        Sleep, 50
        Send, 4
        Sleep, 50
    }
return

; Optional: ESC key to exit script
Esc::ExitApp