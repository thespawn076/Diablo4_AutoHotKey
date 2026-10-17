#NoEnv
SendMode Input

$F::
    fCounter := 0
    while GetKeyState("F", "P")
    {
        fCounter++
        ; Elke 1e loop: toets 1
        if (Mod(fCounter, 6) = 1)
            Send, {1}
        ; Elke 2e loop: toets 2
        if (Mod(fCounter, 6) = 2)
            Send, {2}
        ; Elke 3e loop: toets 3
        if (Mod(fCounter, 6) = 3)
            Send, {3}
        ; Elke 4e loop: toets 4
        if (Mod(fCounter, 6) = 4)
            Send, {4}
        ; Elke 5e loop: linker muisknop
        if (Mod(fCounter, 6) = 5)
            Click
        ; Elke 6e loop: rechter muisknop
        if (Mod(fCounter, 6) = 0)
            Click Right
        Sleep, 25
    }
return

^Esc::ExitApp
return