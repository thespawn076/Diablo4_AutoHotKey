#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Function to handle the key sequence
HandleKeySequence() {
    ; Send key 1
    Send, 1
    Sleep, 100  ; Small delay between keypresses
    
    ; Send key 2
    Send, 2
    Sleep, 100
    
    ; Send key 3
    Send, 3
    Sleep, 100
    
    ; Send key 4
    Send, 4
    Sleep, 100
    
    return
}

; Tilde key (~) press detection
~::
    ; Start the key sequence when tilde is pressed
    HandleKeySequence()
    return