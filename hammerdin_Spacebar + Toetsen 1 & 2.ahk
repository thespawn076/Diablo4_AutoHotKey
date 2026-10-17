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
    }
    
    Send, {Space up}
return

^Esc::ExitApp
return