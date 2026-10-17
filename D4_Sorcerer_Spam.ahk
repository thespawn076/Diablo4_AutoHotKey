; ============================================================
;  Diablo 4 – Sorcerer Skill Spammer
;  Houd RECHTERMUISKNOP ingedrukt om alle skills te spammen
;  Keys: 1, 2, 3, 4, LMB, RMB (continu herhalen)
; ============================================================
;  HOE GEBRUIK:
;    1. Dubbelklik dit bestand (AutoHotkey v1 of v2 vereist)
;    2. Houd je RECHTERMUISKNOP ingedrukt in Diablo 4
;    3. Alle skills worden automatisch herhaald
;    4. Laat RMB los om te stoppen
;    5. Druk op F10 om het script te beëindigen
; ============================================================

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
SendMode Input

; ── Instellingen ────────────────────────────────────────────
; Vertraging (ms) tussen elke actie in de cyclus
; Verlaag voor sneller spammen, verhoog als het spel lagged
ActionDelay := 80

; Vertraging (ms) vóór LMB / RMB clicks (iets langer = stabieler)
ClickDelay  := 50

; ── Globale staat ────────────────────────────────────────────
global Spamming := false
global ActionDelay
global ClickDelay

; ── RMB: indrukken = starten, loslaten = stoppen ─────────────
~RButton::
    if !Spamming {
        Spamming := true
        SetTimer, SpamLoop, 1
    }
return

~RButton Up::
    Spamming := false
    SetTimer, SpamLoop, Off
return

; ── De spam-loop ─────────────────────────────────────────────
SpamLoop:
    if !Spamming {
        SetTimer, SpamLoop, Off
        return
    }

    ; Skill 1
    Send, {1 down}
    Sleep, %ActionDelay%
    Send, {1 up}
    if !Spamming
        return

    ; Skill 2
    Send, {2 down}
    Sleep, %ActionDelay%
    Send, {2 up}
    if !Spamming
        return

    ; Skill 3
    Send, {3 down}
    Sleep, %ActionDelay%
    Send, {3 up}
    if !Spamming
        return

    ; Skill 4
    Send, {4 down}
    Sleep, %ActionDelay%
    Send, {4 up}
    if !Spamming
        return

    ; Linkermuisknop click
    Sleep, %ClickDelay%
    Click, left
    if !Spamming
        return

    ; Kleine pauze voor stabiliteit
    Sleep, %ActionDelay%

return

; ── F10 = script beëindigen ──────────────────────────────────
F10::ExitApp
