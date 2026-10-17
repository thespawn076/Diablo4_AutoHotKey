#Requires AutoHotkey v2.0

SetTimer(PressKeys, 100)  ; Run every 100ms for continuous casting

PressKeys() {
    Send("4")
    Sleep(50)  ; Small delay between casts
}