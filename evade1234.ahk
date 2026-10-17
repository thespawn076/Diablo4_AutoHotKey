#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability

; Variable to track script state
ScriptActive := 1

; Variable to track which number key to press next (1-4)
KeyCounter := 1

; Define the spacebar behavior
$Space::
    if (ScriptActive) {
        ; When the spacebar is held down, repeatedly send the spacebar key
        While GetKeyState("Space", "P") ; Check if the spacebar is being held
        {
            Send, {Space} ; Send a spacebar key press
            
            ; Send the current number key (1, 2, 3, or 4)
            if (KeyCounter = 1) {
                Send, 1
            } else if (KeyCounter = 2) {
                Send, 2
            } else if (KeyCounter = 3) {
                Send, 3
            } else if (KeyCounter = 4) {
                Send, 4
            }
            
            ; Increment counter and reset to 1 after 4
            KeyCounter++
            if (KeyCounter > 4) {
                KeyCounter := 1
            }
            
            Sleep, 50 ; Delay between presses
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