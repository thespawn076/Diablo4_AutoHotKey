; ============================================================
;  Diablo 4 - Skill Rotation Script  v2  (met overlay)
;  F1 = Aanzetten | F2 = Uitzetten
;  Rotatie: LMB -> 1 -> 2 -> 3 -> 4 -> herhalen
; ============================================================

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Instellingen ---
loopDelay  := 150   ; ms tussen elke skill-stap
skillDelay := 80    ; ms pauze ná elke toets

; --- Status ---
running := false
currentStep := 0

; --- Tray ---
TraySetIcon("shell32.dll", 77)
A_TrayMenu.Delete()
A_TrayMenu.Add("Stop (F2)",  (*) => StopRotation())
A_TrayMenu.Add("Exit",       (*) => ExitApp())

; ============================================================
;  Overlay venster bouwen
; ============================================================
global overlayGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20", "D4 Overlay")
overlayGui.BackColor := "0d0d0d"

; Decoratieve bovenrand (goud)
topBar := overlayGui.Add("Progress", "x0 y0 w220 h3 c8B6914 Background0d0d0d", 100)

; Diablo-stijl titel
overlayGui.SetFont("s7 cA08050 Bold", "Trebuchet MS")
overlayGui.Add("Text", "x0 y8 w220 Center", "⚔  DIABLO IV  ⚔")

; Scheidingslijn
overlayGui.SetFont("s6 c3a3a3a", "Trebuchet MS")
overlayGui.Add("Text", "x10 y22 w200 Center", "────────────────")

; Status label (groot, kleur wisselt)
overlayGui.SetFont("s15 cFF2020 Bold", "Trebuchet MS")
global statusLabel := overlayGui.Add("Text", "x0 y32 w220 Center", "● UIT")

; Skill indicator labels
overlayGui.SetFont("s7 c606060", "Trebuchet MS")
overlayGui.Add("Text", "x10 y58 w200 Center", "LMB  ▸  1  ▸  2  ▸  3  ▸  4")

; Actieve step highlight
overlayGui.SetFont("s7 c404040", "Trebuchet MS")
global stepLabel := overlayGui.Add("Text", "x10 y70 w200 Center", "─  –  –  –  –")

; Onderrand goud
botBar := overlayGui.Add("Progress", "x0 y85 w220 h2 c8B6914 Background0d0d0d", 100)

; Keybind hint
overlayGui.SetFont("s6 c3a3a3a", "Trebuchet MS")
overlayGui.Add("Text", "x0 y89 w220 Center", "F1 start  ·  F2 stop")

; Venster grootte en positie (rechtsbovenhoek)
overlayGui.Show("x20 y20 w220 h104 NoActivate")

; Transparantie instellen (0=doorzichtig, 255=volledig)
WinSetTransparent(210, overlayGui)

; ============================================================
;  F1 - Start
; ============================================================
F1:: {
    global running
    if running
        return
    running := true
    SetTimer(RunRotation, loopDelay)
    UpdateOverlay()
    FlashOverlay()
}

; ============================================================
;  F2 - Stop
; ============================================================
F2:: StopRotation()

StopRotation() {
    global running, currentStep
    running := false
    currentStep := 0
    SetTimer(RunRotation, 0)
    UpdateOverlay()
}

; ============================================================
;  Overlay updaten
; ============================================================
UpdateOverlay() {
    global running, statusLabel, stepLabel, currentStep, overlayGui

    stepNames := ["LMB", "1", "2", "3", "4"]
    indicators := []
    loop 5 {
        indicators.Push(A_Index = currentStep + 1 ? "◆" : "◇")
    }
    stepLabel.Value := indicators[1] "  " indicators[2] "  " indicators[3] "  " indicators[4] "  " indicators[5]

    if running {
        statusLabel.Opt("cFF4500")
        statusLabel.Value := "▶  AAN"
        overlayGui.BackColor := "0d0d0d"
    } else {
        statusLabel.Opt("c555555")
        statusLabel.Value := "■  UIT"
    }
}

; Flash effect bij aanzetten
FlashOverlay() {
    global overlayGui
    loop 3 {
        WinSetTransparent(255, overlayGui)
        Sleep(80)
        WinSetTransparent(210, overlayGui)
        Sleep(80)
    }
}

; ============================================================
;  Rotatie
; ============================================================
RunRotation() {
    global running, skillDelay, currentStep

    if !running
        return

    ; Optioneel: alleen in Diablo actief
    ; if !WinActive("ahk_exe Diablo IV.exe")
    ;     return

    switch currentStep {
        case 0:
            DllCall("mouse_event", "UInt", 0x0002, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)  ; LMB neer
            Sleep(30)
            DllCall("mouse_event", "UInt", 0x0004, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)  ; LMB los
        case 1: Send("{1}")
        case 2: Send("{2}")
        case 3: Send("{3}")
        case 4: Send("{4}")
    }

    Sleep(skillDelay)
    currentStep := Mod(currentStep + 1, 5)
    UpdateOverlay()
}
