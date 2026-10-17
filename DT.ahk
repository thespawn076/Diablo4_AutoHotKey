#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
; Global variables
global sleepDuration := 50  ; Delay between actions in milliseconds
; Run the sequence only while holding the backtick/tilde key (`)
`::
    ToolTip, Sequence Running, 0, 0
    while (GetKeyState("``", "P")) {  ; Keep running while the key is held
        Send, 2
        Sleep, %sleepDuration%
        Send, 1
        Sleep, 100
        Send, 3
        Sleep, %sleepDuration%
    }
    ToolTip
return
; Emergency stop hotkey (Ctrl + Alt + X)
^!x::
    ToolTip, Script Stopped, 0, 0
    SetTimer, RemoveToolTip, -1000
return
RemoveToolTip:
    ToolTip
return