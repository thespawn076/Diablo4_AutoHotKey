#NoEnv
SendMode Input
#SingleInstance Force

; Status variabelen
ScriptActive := 0   ; Start uitgeschakeld
KeyCounter := 1

; ---- Overlay linksboven (klik-door, altijd bovenop) ----
Gui, Overlay:New, +AlwaysOnTop -Caption +ToolWindow +E0x20 +LastFound
Gui, Overlay:Color, 111111
Gui, Overlay:Font, s12 bold, Segoe UI
Gui, Overlay:Add, Text, vStatusText w200 Center cFF4040, Rotatie: UIT
WinSet, Transparent, 210
Gui, Overlay:Show, x10 y10 NoActivate, RotationOverlay
return

; ---- Hoofdloop (timer) ----
SpamLoop:
if (ScriptActive) {
    ; Huidige skill (1, 2, 3 of 4)
    Send, %KeyCounter%

    ; Counter omhoog, na 4 terug naar 1
    KeyCounter := (KeyCounter >= 4) ? 1 : KeyCounter + 1
}
return

; ---- F1 = AAN ----
F1::
if (!ScriptActive) {
    ScriptActive := 1
    KeyCounter := 1
    SetTimer, SpamLoop, 50   ; Pas aan voor snelheid (lager = sneller)
    GuiControl, Overlay:+c00FF00, StatusText
    GuiControl, Overlay:, StatusText, Rotatie: AAN
}
return

; ---- F2 = UIT ----
F2::
if (ScriptActive) {
    ScriptActive := 0
    SetTimer, SpamLoop, Off
    GuiControl, Overlay:+cFF4040, StatusText
    GuiControl, Overlay:, StatusText, Rotatie: UIT
}
return

; ---- Noodstop ----
^Esc::ExitApp