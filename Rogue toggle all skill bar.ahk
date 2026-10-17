#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
 
; Global variables
global isRunning := false
global sleepDuration := 50  ; Delay between actions in milliseconds
 
; XButton2 is the forward mouse button
XButton2::
    isRunning := !isRunning  ; Toggle the script state
    if (isRunning) {
        SetTimer, ClickSequence, 50  ; Start the sequence
        SoundPlay, *64  ; Play a sound to indicate activation
        ToolTip, Sequence Active, 0, 0
    } else {
        SetTimer, ClickSequence, Off  ; Stop the sequence
        SoundPlay, *16  ; Play a different sound to indicate deactivation
        SetTimer, RemoveToolTip, -1000
    }
return
 
ClickSequence:
    if (!isRunning)
        return
    ; Press 1 
    Send, 1
    Sleep, %sleepDuration%
    ; Press 2
    Send, 2
    Sleep, %sleepDuration%
    ; Shift + Left Click
    Send, {Shift down}
    Click left
    Send, {Shift up}
    Sleep, %sleepDuration%
    ; Press 4 (new addition)
    Send, 4
    Sleep, %sleepDuration%
    ; Right click
    Click right
    Sleep, %sleepDuration%
return
 
RemoveToolTip:
    ToolTip
return
 
; Emergency stop hotkey (Ctrl + Alt + X)
^!x::
    isRunning := false
    SetTimer, ClickSequence, Off
    ToolTip, Script Stopped, 0, 0
    SetTimer, RemoveToolTip, -1000
    SoundPlay, *16
return