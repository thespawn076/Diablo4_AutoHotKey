#NoEnv
SendMode Input

$Space::
    Send, {Space down}
    spaceCounter := 0
    while GetKeyState("Space", "P")
    {
        ; Spacebar elke loop triggeren
        Send, {Space}
        Sleep, 25
        spaceCounter++
        ; Elke 2e loop: toets 1
        if (Mod(spaceCounter, 2) = 0)
            Send, {1}
        ; Elke 4e loop: toets 2
        if (Mod(spaceCounter, 4) = 0)
            Send, {2}
        ; Elke 6e loop: toets 3
        if (Mod(spaceCounter, 6) = 0)
            Send, {3}
        ; Elke 8e loop: toets 4
        if (Mod(spaceCounter, 8) = 0)
            Send, {4}
    }
    Send, {Space up}
return

$LButton::
    Send, {LButton down}
    clickCounter := 0
    while GetKeyState("LButton", "P")
    {
        Send, {LButton}
        Sleep, 25
        clickCounter++
        if (Mod(clickCounter, 2) = 0)
            Send, {1}
        if (Mod(clickCounter, 4) = 0)
            Send, {2}
        if (Mod(clickCounter, 6) = 0)
            Send, {3}
        if (Mod(clickCounter, 8) = 0)
            Send, {4}
    }
    Send, {LButton up}
return

$RButton::
    Send, {RButton down}
    rightClickCounter := 0
    while GetKeyState("RButton", "P")
    {
        Send, {RButton}
        Sleep, 25
        rightClickCounter++
        if (Mod(rightClickCounter, 2) = 0)
            Send, {1}
        if (Mod(rightClickCounter, 4) = 0)
            Send, {2}
        if (Mod(rightClickCounter, 6) = 0)
            Send, {3}
        if (Mod(rightClickCounter, 8) = 0)
            Send, {4}
    }
    Send, {RButton up}
return

^Esc::ExitApp
return