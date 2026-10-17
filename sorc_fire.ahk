; Diablo Skill Rotation Script
; Hold and spam 1 for Fireball with automatic skill rotation
; Press F8 to toggle script on/off

#SingleInstance Force
#MaxThreadsPerHotkey 2

; Configuration - Adjust these keybinds to match your game
FireballKey := "1"
FamiliarKey := "2"
UnstableCurrentsKey := "3"
FrostboltKey := "4"

; Timing variables (in milliseconds)
FrostboltInterval := 4500  ; 4.5 seconds
FamiliarInterval := 8000   ; 8 seconds
InitialFrostbolts := 3     ; Cast 3 times initially

; State variables
ScriptEnabled := false
FrostboltTimer := 0
FamiliarTimer := 0
FrostboltInitialized := false
FrostboltCount := 0

; Toggle script on/off with F8
F8::
    global ScriptEnabled
    global FrostboltTimer
    global FamiliarTimer
    global FrostboltInitialized
    global FrostboltCount
    
    ScriptEnabled := !ScriptEnabled
    if (ScriptEnabled) {
        ToolTip, Skill Rotation: ON
        ; Reset timers when enabling
        FrostboltTimer := A_TickCount
        FamiliarTimer := A_TickCount
        FrostboltInitialized := false
        FrostboltCount := 0
    } else {
        ToolTip, Skill Rotation: OFF
    }
    SetTimer, RemoveToolTip, 2000
return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return

; Main skill rotation when holding/spamming 1
$1::
    global ScriptEnabled
    global FireballKey
    global FamiliarKey
    global UnstableCurrentsKey
    global FrostboltKey
    global FrostboltInterval
    global FamiliarInterval
    global InitialFrostbolts
    global FrostboltTimer
    global FamiliarTimer
    global FrostboltInitialized
    global FrostboltCount
    
    if (!ScriptEnabled) {
        Send {%FireballKey%}
        return
    }
    
    ; Loop while key 1 is held down
    While GetKeyState("1", "P") {
        CurrentTime := A_TickCount
        
        ; Initial Frostbolt burst (3 casts) when script first starts
        if (!FrostboltInitialized) {
            if (FrostboltCount < InitialFrostbolts) {
                Send {%FrostboltKey%}
                Sleep 50
                FrostboltCount++
                continue
            } else {
                FrostboltInitialized := true
                FrostboltTimer := CurrentTime
                FamiliarTimer := CurrentTime
            }
        }
        
        ; Cast Unstable Currents first for attack speed buff
        Send {%UnstableCurrentsKey%}
        Sleep 50
        
        ; Check if Frostbolt needs to be cast (every 4.5 seconds)
        if (CurrentTime - FrostboltTimer >= FrostboltInterval) {
            Send {%FrostboltKey%}
            Sleep 50
            FrostboltTimer := CurrentTime
        }
        
        ; Check if Familiar needs to be cast (every 8 seconds)
        if (CurrentTime - FamiliarTimer >= FamiliarInterval) {
            Send {%FamiliarKey%}
            Sleep 50
            FamiliarTimer := CurrentTime
        }
        
        ; Always cast Fireball
        Send {%FireballKey%}
        Sleep 100  ; Adjust this delay for spam speed (lower = faster)
    }
return

; Exit script with F9
F9::
    ToolTip, Script Exiting...
    Sleep 1000
    ExitApp
return