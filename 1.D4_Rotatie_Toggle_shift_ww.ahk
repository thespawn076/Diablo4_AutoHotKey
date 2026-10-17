#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; ─── Staat ───────────────────────────────────────────
global scriptActief := false
global fCounter := 0

; ─── Overlay GUI ─────────────────────────────────────
Gui, Overlay:New, +AlwaysOnTop +ToolWindow -Caption +E0x20, Overlay
Gui, Overlay:Color, 000000
Gui, Overlay:Font, s13 Bold, Segoe UI
Gui, Overlay:Add, Text, vTekstUit cRed,  ROTATIE UIT
Gui, Overlay:Add, Text, vTekstAan cLime, ROTATIE AAN
Gui, Overlay:Show, x10 y10 NoActivate, Overlay
WinSet, TransColor, 000000 200, Overlay
UpdateOverlay()
return

; ─── F1 = Inschakelen ────────────────────────────────
F1::
    if (scriptActief)
        return
    scriptActief := true
    UpdateOverlay()
    SetTimer, RotatieLoop, 25
    SetTimer, ShiftLMBLoop, 2000
return

; ─── F2 = Uitschakelen ───────────────────────────────
F2::
    scriptActief := false
    SetTimer, RotatieLoop, Off
    SetTimer, ShiftLMBLoop, Off
    fCounter := 0
    UpdateOverlay()
return

; ─── Rotatie loop (automatisch, geen knop ingehouden) ─
RotatieLoop:
    fCounter++
    if (Mod(fCounter, 4) = 1)
        Send, {1}
    if (Mod(fCounter, 4) = 2)
        Send, {2}
    if (Mod(fCounter, 4) = 3)
        Send, {3}
    if (Mod(fCounter, 4) = 0)
        Send, {4}
return

; ─── Elke 2 seconden: Shift + LMB ────────────────────
ShiftLMBLoop:
    if (!scriptActief)
        return
    SendInput, {Shift down}{LButton}{Shift up}
return

; ─── Overlay bijwerken ───────────────────────────────
UpdateOverlay()
{
    global scriptActief
    if (scriptActief)
    {
        GuiControl, Overlay:Hide, TekstUit
        GuiControl, Overlay:Show, TekstAan
    }
    else
    {
        GuiControl, Overlay:Show, TekstUit
        GuiControl, Overlay:Hide, TekstAan
    }
}

; ─── Afsluiten ───────────────────────────────────────
^Esc::
    SetTimer, RotatieLoop, Off
    SetTimer, ShiftLMBLoop, Off
    Gui, Overlay:Destroy
    ExitApp
return