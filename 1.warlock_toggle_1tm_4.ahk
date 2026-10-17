#Requires AutoHotkey v2.0
#SingleInstance Force

; Globale variabelen
global isActive := false
global skillDelay := 100      ; Vertraging tussen skills in milliseconden
global skill3Cooldown := 1000 ; Cooldown voor skill 3 (2000ms = 2 seconden)
global lastSkill3Time := 0    ; Tijdstip laatste keer skill 3

; ============================================
; OVERLAY GUI MAKEN
; ============================================
overlayGui := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
overlayGui.BackColor := "1a1a1a"
overlayGui.SetFont("s14 Bold", "Segoe UI")

; Status tekst
statusText := overlayGui.Add("Text", "x10 y10 w180 h40 Center cRed", "● UIT")
statusText.SetFont("s16 Bold")

; Info tekst
overlayGui.SetFont("s9", "Segoe UI")
overlayGui.Add("Text", "x10 y55 w180 Center c888888", "F1 = AAN  |  F2 = UIT")

; Transparantie instellen (0 = onzichtbaar, 255 = volledig zichtbaar)
WinSetTransparent(180, overlayGui)

; Toon overlay LINKSBOVEN
overlayGui.Show("x20 y20 w200 h85 NoActivate")

; ============================================
; HOTKEYS VOOR TOGGLE
; ============================================
F1:: {
    global isActive := true
    UpdateOverlay()
}

F2:: {
    global isActive := false
    UpdateOverlay()
}

; ============================================
; OVERLAY UPDATEN
; ============================================
UpdateOverlay() {
    if (isActive) {
        statusText.Text := "● AAN"
        statusText.SetFont("cLime")
        overlayGui.BackColor := "0a2a0a"
    } else {
        statusText.Text := "● UIT"
        statusText.SetFont("cRed")
        overlayGui.BackColor := "1a1a1a"
    }
}

; ============================================
; HOOFDFUNCTIE - SKILLS TRIGGEREN
; ============================================
; "1" ingedrukt houden triggert 1,2,3,4 herhaaldelijk
*1:: {
    global lastSkill3Time
    
    if (!isActive) {
        ; Als script uit staat, gewoon normale "1" sturen
        Send("1")
        return
    }
    
    ; Loop zolang "1" ingedrukt is
    while GetKeyState("1", "P") {
        if (!isActive)
            break
            
        ; --- Skill 1 ---
        Send("1")
        Sleep(skillDelay)
        
        if (!GetKeyState("1", "P"))
            break
            
        ; --- Skill 2 ---
        Send("2")
        Sleep(skillDelay)
        
        if (!GetKeyState("1", "P"))
            break
            
        ; --- Skill 3 (alleen als 2 seconden voorbij zijn) ---
        if (A_TickCount - lastSkill3Time >= skill3Cooldown) {
            Send("3")
            lastSkill3Time := A_TickCount
            Sleep(skillDelay)
        }
        
        if (!GetKeyState("1", "P"))
            break
            
        ; --- Skill 4 ---
        Send("4")
        Sleep(skillDelay)
    }
}