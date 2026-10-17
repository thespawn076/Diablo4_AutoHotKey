#Persistent
#SingleInstance, Force

; Toggle variable to control script state
IsRunning := false

; Hotkey to toggle the script on/off (F3 in this example)
F3::
    IsRunning := !IsRunning
    if (IsRunning) {
        SetTimer, ClickWhirlwind, 1600 ; 1.6 seconds between clicks
        SoundPlay, *48 ; Play a sound to indicate script is active
        ToolTip, Whirlwind Script: ON
    } else {
        SetTimer, ClickWhirlwind, Off
        ToolTip ; Clear the tooltip
        SoundPlay, *16 ; Play a sound to indicate script is inactive
    }
return

; Subroutine to perform the right-click
ClickWhirlwind:
    Click, right
return

; Escape key to exit the script completely
Esc::ExitApp