#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

; ============================================================
;  Ancient Push Rotation - AutoHotkey Script
;  F1 = Start rotation
;  F2 = Stop rotation
; ============================================================
;
;  Skill keybindings (pas aan als jouw keys anders zijn):
;    1 = Iron Skin
;    2 = Rallying Cry
;    3 = Challenging Shout
;    4 = War Cry
;  LMB = Call of the Ancients  (muisknop links)
;  RMB = Mighty Throw           (muisknop rechts)
;
; ============================================================

global Running := false

; ------ Timings (milliseconden) ------
; Pas deze aan naar jouw GCD / animatietijden
CAST_DELAY    := 250   ; korte pauze tussen skills
SHOUT_DELAY   := 300   ; iets langer voor shouts
MIGHTY_DELAY  := 500   ; Mighty Throw animatie
LOOP_PAUSE    := 100   ; kleine pauze einde loop

; ==================== TOGGLE KEYS ====================

F1::
    Running := true
    SetTimer, RunRotation, -1   ; start eenmalig, loop zit in de subroutine
    ToolTip, ROTATION ON - F2 om te stoppen, 0, 0
return

F2::
    Running := false
    ToolTip, ROTATION OFF - F1 om te starten, 0, 0
    SetTimer, ClearTip, -2000
return

ClearTip:
    ToolTip
return

; ==================== ROTATIE LOOP ====================

RunRotation:
    ; --- Stap 1: Iron Skin (Resolve Stacks opbouwen - gebruik altijd op cooldown) ---
    if !Running
        return
    Send, 1                         ; Iron Skin
    Sleep, %CAST_DELAY%

    ; --- Stap 2: Rallying Cry (spam het) ---
    if !Running
        return
    Send, 2                         ; Rallying Cry
    Sleep, %CAST_DELAY%

    ; --- Stap 3: Call of the Ancients (LMB) ---
    if !Running
        return
    Click, Left                     ; Call of the Ancients
    Sleep, %CAST_DELAY%

    ; --- Stap 4: War Cry + Challenging Shout → Marshal activeren ---
    if !Running
        return
    Send, 4                         ; War Cry
    Sleep, %CAST_DELAY%
    Send, 3                         ; Challenging Shout
    Sleep, %SHOUT_DELAY%

    ; --- Stap 5: Mighty Throw (10 sec van CotA cooldown afhalen) ---
    if !Running
        return
    Click, Right                    ; Mighty Throw
    Sleep, %MIGHTY_DELAY%

    ; --- Stap 6: War Cry + Challenging Shout → Marshal activeren ---
    if !Running
        return
    Send, 4                         ; War Cry
    Sleep, %CAST_DELAY%
    Send, 3                         ; Challenging Shout
    Sleep, %SHOUT_DELAY%

    ; --- Stap 7: Call of the Ancients opnieuw (LMB) ---
    if !Running
        return
    Click, Left                     ; Call of the Ancients
    Sleep, %CAST_DELAY%

    ; --- Stap 8: War Cry + Challenging Shout → Marshal activeren ---
    if !Running
        return
    Send, 4                         ; War Cry
    Sleep, %CAST_DELAY%
    Send, 3                         ; Challenging Shout
    Sleep, %SHOUT_DELAY%

    ; --- Stap 9: Mighty Throw (10 sec van CotA cooldown afhalen) ---
    if !Running
        return
    Click, Right                    ; Mighty Throw
    Sleep, %MIGHTY_DELAY%

    ; --- Tussendoor: Iron Skin opnieuw als cooldown misschien klaar is ---
    if !Running
        return
    Send, 1                         ; Iron Skin
    Sleep, %CAST_DELAY%

    ; --- Korte pauze en dan herhalen ---
    Sleep, %LOOP_PAUSE%

    if Running
        SetTimer, RunRotation, -1   ; herstart de loop
return
