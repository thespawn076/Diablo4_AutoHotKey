; ============================================================
;  Diablo 4 — Whirlwind Barb macro  v2
;  Rechtermuisknop channelt Whirlwind + Skills 1/2/3/4
;
;  AAN/UIT : F1
;  STOPPEN  : Escape
; ============================================================

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Instellingen -------------------------------------------
SKILL_INTERVAL  := 500   ; ms tussen elke skill (verlaag voor sneller)
SKILL_HOLD_MS   := 80    ; ms dat de skill-knop ingedrukt blijft
; ------------------------------------------------------------

global MacroActive := false
global SkillIndex  := 1

F1:: ToggleMacro()

ToggleMacro() {
    global MacroActive
    MacroActive := !MacroActive

    if MacroActive {
        ToolTip("⚔  WW Barb ACTIEF  —  F1 om te stoppen")
        SetTimer(HoldRMB,   16)
        SetTimer(FireSkill, SKILL_INTERVAL)
    } else {
        SetTimer(HoldRMB,   0)
        SetTimer(FireSkill, 0)
        Send("{RButton up}")
        ToolTip()
    }
}

HoldRMB() {
    if !MacroActive
        return
    Send("{RButton down}")
}

FireSkill() {
    global MacroActive, SkillIndex, SKILL_HOLD_MS
    if !MacroActive
        return

    key := String(SkillIndex)
    Send("{" key " down}")
    Sleep(SKILL_HOLD_MS)
    Send("{" key " up}")

    SkillIndex := (SkillIndex >= 4) ? 1 : SkillIndex + 1
}

Escape:: {
    global MacroActive
    MacroActive := false
    SetTimer(HoldRMB,   0)
    SetTimer(FireSkill, 0)
    Send("{RButton up}")
    ToolTip()
    ExitApp()
}
