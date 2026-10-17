#NoEnv
#SingleInstance Force
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
    SetTimer, MuisklikLoop, 3800
return

; ─── F2 = Uitschakelen ───────────────────────────────
F2::
    scriptActief := false
    SetTimer, RotatieLoop, Off
    SetTimer, MuisklikLoop, Off
    fCounter := 0
    UpdateOverlay()
return

; ─── Rotatie loop ────────────────────────────────────
RotatieLoop:
    fCounter++
    if (Mod(fCounter, 4) = 1)
        SendEvent, {1}
    if (Mod(fCounter, 4) = 2)
        SendEvent, {2}
    if (Mod(fCounter, 4) = 3)
        SendEvent, {3}
    if (Mod(fCounter, 4) = 0)
        SendEvent, {4}
return

; ─── Shift + Linker muisklik loop (elke 3,8 sec) ─────
MuisklikLoop:
    SendEvent, {LShift Down}
    Sleep, 50
    SendEvent, {LButton Down}
    Sleep, 50
    SendEvent, {LButton Up}
    Sleep, 50
    SendEvent, {LShift Up}
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
    Gui, Overlay:Destroy
    ExitApp
return