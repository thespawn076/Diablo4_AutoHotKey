; AutoHotkey script to hold down spacebar for repeated actions

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability

; Define the spacebar behavior
$Space::
    ; When the spacebar is held down, repeatedly send the spacebar key
    While GetKeyState("Space", "P") ; Check if the spacebar is being held
    {
        Send, {Space} ; Send a spacebar key press
        Sleep, 50 ; Adjust the delay (in milliseconds) between presses
    }
return

; Exit script with a hotkey (Ctrl+Esc in this case)
^Esc::
    ExitApp
return
