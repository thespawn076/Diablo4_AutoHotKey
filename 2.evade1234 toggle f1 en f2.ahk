#NoEnv
SendMode Input
#SingleInstance Force

; Variabele om script status bij te houden
ScriptActive := 0  ; Start uitgeschakeld
KeyCounter := 1

; Timer label voor de loop
Loop:
    if (ScriptActive) {
        ; Stuur spatiebalk voor evade
        Send, {Space}
        
        ; Stuur huidige skill (1, 2, 3, of 4)
        Send, %KeyCounter%
        
        ; Verhoog counter en reset na 4
        KeyCounter := (KeyCounter >= 4) ? 1 : KeyCounter + 1
        
        Sleep, 50  ; Pas aan voor snelheid (lager = sneller)
    }
return

; F1 om te ACTIVEREN
F1::
    if (!ScriptActive) {
        ScriptActive := 1
        KeyCounter := 1  ; Reset naar skill 1
        SetTimer, Loop, 50  ; Start de loop
        ToolTip, Script ACTIEF - Evade + Skills 1-2-3-4
        SetTimer, RemoveToolTip, -2000
    }
return

; F2 om te STOPPEN
F2::
    if (ScriptActive) {
        ScriptActive := 0
        SetTimer, Loop, Off  ; Stop de loop
        ToolTip, Script GESTOPT
        SetTimer, RemoveToolTip, -2000
    }
return

; Verwijder tooltip
RemoveToolTip:
    ToolTip
return

; Noodstop met Ctrl+Esc
^Esc::ExitApp