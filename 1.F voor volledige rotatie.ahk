#NoEnv
SendMode Input

$F::
    fCounter := 0
    while GetKeyState("F", "P")
    {
        fCounter++
        ; Elke 1e loop: toets 1
        if (Mod(fCounter, 4) = 1)
            Send, {1}
        ; Elke 2e loop: toets 2
        if (Mod(fCounter, 4) = 2)
            Send, {2}
        ; Elke 3e loop: toets 3
        if (Mod(fCounter, 4) = 3)
            Send, {3}
        ; Elke 4e loop: toets 4
        if (Mod(fCounter, 4) = 0)
            Send, {4}
        Sleep, 25
    }
return

^Esc::ExitApp
return