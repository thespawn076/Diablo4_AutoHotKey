#NoEnv
SendMode Input
#SingleInstance Force

; Variabele om script status bij te houden
ScriptActive := 0  ; Start uitgeschakeld
SkillCounter := 2  ; Voor skills 2, 3, 4

; Timer label voor de loop
Loop:
if (ScriptActive) {
    ; ALTIJD: Skill 1 + Evade (spacebar)
    Send, 1
    Sleep, 30
    Send, {Space}
    Sleep, 30
    
    ; Voeg skill 2, 3, of 4 toe (roterend)
    Send, %SkillCounter%
    Sleep, 30
    
    ; Evade na elke skill
    Send, {Space}
    Sleep, 30
    
    ; Verhoog counter voor skills 2-3-4 en reset na 4
    SkillCounter := (SkillCounter >= 4) ? 2 : SkillCounter + 1
}
return

; F1 om te ACTIVEREN
F1::
if (!ScriptActive) {
    ScriptActive := 1
    SkillCounter := 2  ; Reset naar skill 2
    SetTimer, Loop, 50  ; Start de loop
    ToolTip, Script ACTIEF - 1+Evade + Skills 2-3-4
    SetTimer, RemoveToolTip, -2000
}
return

; F2 om te STOPPEN
F2::
if (!ScriptActive) {
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