#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%

; Global variables
global isHoldingSpace := false
global sleepDuration := 100  ; Delay between skill casts in milliseconds
global evadeInterval := 300  ; Delay before repeating evade in milliseconds

; Spacebar - Hold to evade and cast skills
Space::
    isHoldingSpace := true
    SoundPlay, *64  ; Activation sound
    ToolTip, Evade + Skills Active, 0, 0
    
    lastEvadeTime := 0
    
    ; Hold space and cycle skills
    while (isHoldingSpace && GetKeyState("Space", "P"))
    {
        currentTime := A_TickCount
        
        ; Send evade (spacebar) periodically
        if (currentTime - lastEvadeTime >= evadeInterval)
        {
            Send, {Space}
            lastEvadeTime := currentTime
            Sleep, 50
        }
        
        ; Press skill 1
        Send, 1
        Sleep, %sleepDuration%
        
        ; Press skill 2
        Send, 2
        Sleep, %sleepDuration%
        
        ; Press skill 3
        Send, 3
        Sleep, %sleepDuration%
        
        ; Press skill 4
        Send, 4
        Sleep, %sleepDuration%
    }
    
    ; Release spacebar
    isHoldingSpace := false
    ToolTip
    SoundPlay, *16  ; Deactivation sound
return

; Emergency stop hotkey (Ctrl + Alt + X)
^!x::
    isHoldingSpace := false
    ToolTip, Script Stopped
    SetTimer, RemoveToolTip, -1000
    SoundPlay, *16
return

RemoveToolTip:
    ToolTip
return