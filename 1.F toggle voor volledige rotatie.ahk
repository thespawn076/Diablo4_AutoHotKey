#NoEnv
SendMode Input
isRunning := false

; Status-venster linksboven aanmaken
Gui, +AlwaysOnTop -Caption +ToolWindow +E0x20  ; klik-doorlaatbaar, geen titelbalk
Gui, Color, Red
Gui, Font, s10 Bold, Arial
Gui, Add, Text, cWhite vStatusText w60 Center, UIT
Gui, Show, x0 y0 NoActivate, Status

F1::
    if (isRunning)
        return   ; Al actief, doe niets

    isRunning := true
    fCounter := 0

    ; Status bijwerken naar AAN (groen)
    Gui, Color, Green
    GuiControl,, StatusText, AAN
    Gui, Show, x0 y0 NoActivate

    while (isRunning)
    {
        fCounter++

        if (Mod(fCounter, 4) = 1)
            Send, {1}
        if (Mod(fCounter, 4) = 2)
            Send, {2}
        if (Mod(fCounter, 4) = 3)
            Send, {3}
        if (Mod(fCounter, 4) = 0)
            Send, {4}

        Sleep, 25
    }

    ; Status bijwerken naar UIT (rood) zodra de loop stopt
    Gui, Color, Red
    GuiControl,, StatusText, UIT
    Gui, Show, x0 y0 NoActivate
return

F2::
    isRunning := false
return

^Esc::ExitApp