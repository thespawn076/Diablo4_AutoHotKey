#NoEnv
SendMode Input

$F::
    fCounter := 0
    while GetKeyState("F", "P")
    {
        fCounter++
        keyToSend := Mod(fCounter - 1, 2) + 1  ; Berekent 1 of 2
        Send, {%keyToSend%}
        Sleep, 25
    }
return

^Esc::ExitApp