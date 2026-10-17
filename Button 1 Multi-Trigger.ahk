#Requires AutoHotkey v2.0

; Track if button 1 is being held and the timer
button1_held := false
button1_timer := ""

; When button 1 is pressed
LButton::
{
    global button1_held, button1_timer
    
    button1_held := true
    button1_timer := SetTimer(FireButtons, 50)  ; Fire every 50ms while held
    
    return
}

; When button 1 is released
LButton up::
{
    global button1_held, button1_timer
    
    button1_held := false
    SetTimer(button1_timer, 0)  ; Stop the timer
    
    return
}

; Function to send button clicks
FireButtons()
{
    global button1_held
    
    if (button1_held)
    {
        Click 1  ; Button 1
        Click 2  ; Button 2
        Click 3  ; Button 3
        Click 4  ; Button 4
    }
}