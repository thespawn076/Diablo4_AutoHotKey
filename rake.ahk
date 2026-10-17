#Persistent
#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

; ===== CONFIGURATIE =====
rakeKey := "1"           ; Rake skill
scourgeKey := "2"        ; Scourge skill
armoredKey := "3"        ; Armored Hide skill
protectorKey := "4"      ; The Protector skill

; Cooldown timings (in milliseconds)
scourgeCD := 12000       ; 12 seconden
armoredCD := 25000       ; 25 seconden
protectorCD := 20000     ; 20 seconden

; Rotation timing
rotationDelay := 400     ; Tijd tussen Rake casts (in ms)

; ===== VARIABELEN =====
rotationActive := false
lastScourge := 0
lastArmored := 0
lastProtector := 0

; ===== SPACEBAR HOLD ROTATION =====
$Space::
    ; Start de rotatie zodra spacebar wordt ingedrukt
    rotationActive := true
    lastScourge := A_TickCount
    lastArmored := A_TickCount
    
    ToolTip, 🟢 ROTATIE ACTIEF - Houd Spacebar vast!, 10, 10
    
    ; Loop zolang spacebar wordt vastgehouden
    While GetKeyState("Space", "P") {
        currentTime := A_TickCount
        
        ; Cast Scourge op cooldown
        if (currentTime - lastScourge >= scourgeCD) {
            Send {%scourgeKey%}
            lastScourge := currentTime
            Sleep 50
        }
        
        ; Cast Armored Hide op cooldown
        if (currentTime - lastArmored >= armoredCD) {
            Send {%armoredKey%}
            lastArmored := currentTime
            Sleep 50
        }
        
        ; CORE ROTATION: Rake -> Evade -> Rake
        ; Cast Rake met Shift
        Send {Shift down}
        Send {%rakeKey%}
        Sleep 80
        Send {Shift up}
        Sleep 100
        
        ; Evade door enemy (spacebar doorsturen naar game)
        Send {Space down}
        Sleep 250
        Send {Space up}
        Sleep 100
        
        ; Cast Rake opnieuw na Evade
        Send {Shift down}
        Send {%rakeKey%}
        Sleep 80
        Send {Shift up}
        
        ; Wacht voor volgende rotatie
        Sleep %rotationDelay%
    }
    
    ; Spacebar losgelaten
    rotationActive := false
    ToolTip, 🔴 ROTATIE GESTOPT, 10, 10
    SetTimer, RemoveToolTip, 1500
return

; ===== RECHTERMUISKNOP VASTHOUDEN =====
; Zorgt ervoor dat rechtermuisknop normaal werkt
~RButton::
return

~RButton Up::
return

; ===== MANUAL PROTECTOR (Q KEY) =====
q::
    currentTime := A_TickCount
    if (currentTime - lastProtector >= protectorCD) {
        Send {%protectorKey%}
        lastProtector := currentTime
        ToolTip, 🛡️ The Protector gebruikt!, 10, 50
        SetTimer, RemoveToolTip, 1500
    } else {
        remaining := Round((protectorCD - (currentTime - lastProtector)) / 1000, 1)
        ToolTip, ⏳ Protector CD: %remaining%s, 10, 50
        SetTimer, RemoveToolTip, 1500
    }
return

; ===== EMERGENCY PROTECTOR (E KEY) =====
e::
    Send {%protectorKey%}
    lastProtector := A_TickCount
    ToolTip, 🚨 EMERGENCY PROTECTOR!, 10, 50
    SetTimer, RemoveToolTip, 1000
return

; ===== TOGGLE VOOR SNELLERE ROTATIE (F1) =====
F1::
    rotationDelay := rotationDelay = 400 ? 250 : 400
    ToolTip, ⚡ Rotatie snelheid: %rotationDelay%ms, 10, 10
    SetTimer, RemoveToolTip, 2000
return

; ===== HULPFUNCTIES =====
RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return

; ===== EXIT SCRIPT (F12) =====
F12::
    ToolTip, ❌ Script afgesloten, 10, 10
    Sleep 1000
    ExitApp
return