#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability

; Variable to track script state
ScriptActive := 1

; Define the spacebar behavior
$Space::
    if (ScriptActive) {
        ; When the spacebar is held down, repeatedly send the spacebar key
        While GetKeyState("Space", "P") ; Check if the spacebar is being held
        {
            Send, {Space} ; Send a spacebar key press
            Sleep, 50 ; Adjust the delay (in milliseconds) between presses
        }
    }
return

; Hotkey to pause the script (F1)
F1::
    ScriptActive := 0
    ToolTip, Script Paused
    SetTimer, RemoveToolTip, -2000
return

; Hotkey to activate the script (F2)
F2::
    ScriptActive := 1
    ToolTip, Script Activated
    SetTimer, RemoveToolTip, -2000
return

; Function to remove the tooltip
RemoveToolTip:
    ToolTip
return

; Exit script with a hotkey (Ctrl+Esc in this case)
^Esc::
    ExitApp
return