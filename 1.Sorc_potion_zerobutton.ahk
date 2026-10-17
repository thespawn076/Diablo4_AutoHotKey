#SingleInstance Force
#Persistent

enabled := false
potionInterval := 500  ; elke halve seconde

; --- Kleine transparante overlay ---
Gui, +AlwaysOnTop -Caption +ToolWindow +Border
Gui, Color, 101010
Gui, Font, s8 cFFFFFF, Segoe UI
Gui, Add, Text, w70 h18 Center vStatusText, UIT
Gui, Show, x20 y20 NoActivate

WinSet, Transparent, 180, A

UpdateOverlay() {
    global enabled
    if (enabled)
        GuiControl,, StatusText, AAN
    else
        GuiControl,, StatusText, UIT
}

F1::
enabled := true
UpdateOverlay()
SetTimer, UsePotion, 500
return

F2::
enabled := false
UpdateOverlay()
SetTimer, UsePotion, Off
return

UsePotion:
if (enabled)
    Send, q
return