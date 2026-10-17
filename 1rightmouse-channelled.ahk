#NoEnv
SetBatchLines -1
#SingleInstance Force

; Variables
RMB_Held := false
Loop_Running := false

; Right Mouse Button Down
RButton::
{
    RMB_Held := true
    Loop_Running := true
    
    ; Start the button pressing loop
    while (Loop_Running && RMB_Held)
    {
        SendInput {1 down}{1 up}
        Sleep 50
        SendInput {2 down}{2 up}
        Sleep 50
        SendInput {3 down}{3 up}
        Sleep 50
        SendInput {4 down}{4 up}
        Sleep 50
        SendInput {LButton down}{LButton up}
        Sleep 50
    }
    return
}

; Right Mouse Button Up
RButton Up::
{
    RMB_Held := false
    Loop_Running := false
    return
}

; ESC to emergency stop
Esc::
{
    Loop_Running := false
    RMB_Held := false
    ExitApp
}