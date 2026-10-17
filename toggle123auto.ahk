#Requires AutoHotkey v2.0

toggleState := false
k::toggleState := !toggleState  ; Press K to toggle on/off

SetTimer(PressKeys, 3000)  ; Run every 3 seconds (1 sec per key + delays)

PressKeys() {
    if (!toggleState)
        return
    
    Send("1")
    Sleep(1000)
    Send("2")
    Sleep(1000)
    Send("3")
    Sleep(1000)
}