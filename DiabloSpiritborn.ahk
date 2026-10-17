#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Global variables
global isSpaceDown := false
global currentKey := 2  ; Start with key 2 in the rotation (after 1)
global keyDelay := 500  ; Delay between key presses in milliseconds

; When space is pressed down
~Space::
    if (!isSpaceDown) {
        isSpaceDown := true
        SetTimer, ActivateSkills, %keyDelay%
    }
return

; When space is released
~Space Up::
    isSpaceDown := false
    SetTimer, ActivateSkills, Off
    currentKey := 2  ; Reset to start with key 2 after next space press
return

; Function to trigger skills
ActivateSkills:
    if (isSpaceDown) {
        ; Always send Space first (evade)
        SendInput, {Space}
        
        ; Always send 1 after Space
        Sleep, %keyDelay%
        SendInput, 1
        
        ; Then send the current rotation key (2, 3, or 4)
        Sleep, %keyDelay%
        SendInput, %currentKey%
        
        ; Move to next key in rotation (2, 3, 4)
        currentKey := currentKey + 1
        if (currentKey > 4) {
            currentKey := 2  ; Reset to 2 after reaching 4
        }
    }
return