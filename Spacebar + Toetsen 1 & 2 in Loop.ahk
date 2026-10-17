#NoEnv
SendMode Input

$Space::
    Send, {Space down}  ; Spacebar indrukken
    
    while GetKeyState("Space", "P")  ; Zolang spacebar wordt ingehouden
    {
        Send, {1}       ; Toets 1 triggeren
        Sleep, 100      ; Wacht 100ms
        
        Send, {2}       ; Toets 2 triggeren
        Sleep, 100      ; Wacht 100ms
    }
    
    Send, {Space up}    ; Spacebar loslaten
return

^Esc::ExitApp
return