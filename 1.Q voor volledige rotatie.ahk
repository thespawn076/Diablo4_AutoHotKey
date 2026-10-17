#NoEnv
SendMode Input

$Space::
    Send, {Space down}
    spaceCounter := 0
    while GetKeyState("Space", "P")
    {
        Send, {Space}
        Sleep, 25
        spaceCounter++
        
        if (Mod(spaceCounter, 2) = 0)
            Send, {1}
        if (Mod(spaceCounter, 4) = 0)
            Send, {2}
        if (Mod(spaceCounter, 6) = 0)
            Send, {3}
        if (Mod(spaceCounter, 8) = 0)
            Send, {4}
    }
    Send, {Space up}
return

$q::
    Send, {q down}
    rotationCounter := 0
    while GetKeyState("q", "P")
    {
        Send, {e}  ; Rotatie toets (aanpassen naar je game)
        Sleep, 50
        rotationCounter++
    }
    Send, {q up}
return

^Esc::ExitApp
return