#Requires AutoHotkey v2.0
; ============================================================
;  Skill Spammer
;  F1 = Aanzetten  |  F2 = Uitzetten
; ============================================================

; --- Instellingen ---
global DELAY := 150
global SKILL_DELAY := 30
global skills := ["1", "2", "3", "4"]
global enabled := false

; --- Status venster (altijd zichtbaar in hoek scherm) ---
global statusGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
statusGui.BackColor := "111111"
global statusText := statusGui.AddText("w180 h34 Center cRed", "● UITGESCHAKELD")
statusText.SetFont("s13 bold", "Consolas")
statusGui.Show("x10 y10 NoActivate")

UpdateStatus() {
    global enabled, statusText
    if enabled {
        statusText.Opt("cLime")
        statusText.Value := "● INGESCHAKELD"
    } else {
        statusText.Opt("cRed")
        statusText.Value := "● UITGESCHAKELD"
    }
}

; ============================================================
;  F1 = Aan  |  F2 = Uit
; ============================================================
~F1:: {
    global enabled
    enabled := true
    UpdateStatus()
}

~F2:: {
    global enabled
    enabled := false
    UpdateStatus()
}

; ============================================================
;  RMB ingedrukt = RMB doorgeven + skills spammen
; ============================================================
RButton:: {
    global enabled, skills, DELAY, SKILL_DELAY
    if !enabled {
        ; Script uit: gewoon normale RMB doorsturen
        SendEvent("{RButton down}")
        KeyWait("RButton")
        SendEvent("{RButton up}")
        return
    }

    ; Script aan: eerste RMB click direct doorsturen
    SendEvent("{RButton down}")

    while GetKeyState("RButton", "P") {
        if !enabled
            break

        ; LMB click
        SendEvent("{LButton down}")
        Sleep(10)
        SendEvent("{LButton up}")
        Sleep(SKILL_DELAY)
        if !GetKeyState("RButton", "P") || !enabled
            break

        ; Keyboard skills 1-4
        for skill in skills {
            Send("{" skill " down}")
            Sleep(10)
            Send("{" skill " up}")
            Sleep(SKILL_DELAY)
            if !GetKeyState("RButton", "P") || !enabled
                break
        }
        Sleep(DELAY)
    }

    SendEvent("{RButton up}")
}
