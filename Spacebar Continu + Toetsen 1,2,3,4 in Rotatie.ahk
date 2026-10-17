#NoEnv
SendMode Input

$Space::
    Send, {Space down}
    
    while GetKeyState("Space", "P")
    {
        Send, {Space}   ; Spacebar triggeren
        Sleep, 50
        
        Send, {1}
        Sleep, 100
        
        Send, {2}
        Sleep, 100
        
        Send, {3}
        Sleep, 100
        
        Send, {4}
        Sleep, 100
    }
    
    Send, {Space up}
return

^Esc::ExitApp
return