#SingleInstance Force  ; Ensures only one instance of the script runs
#NoEnv  ; Recommended for performance and compatibility
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory

; Global variables
global isSpacebarHeld := false
global spaceInterval := 50  ; Delay between space presses in milliseconds (adjust as needed)

; When spacebar is pressed down
$Space::
    if (!isSpacebarHeld) {
        isSpacebarHeld := true
        SetTimer, SendSpacePress, %spaceInterval%
    }
return

; When spacebar is released
$Space Up::
    isSpacebarHeld := false
    SetTimer, SendSpacePress, Off
return

; Function to send space press
SendSpacePress:
    if (isSpacebarHeld) {
        SendInput {Space}
    }
return

; Hotkey to exit script (Ctrl + Q)
^q::ExitApp

; Hotkey to pause/unpause script (Ctrl + P)
^p::Pause