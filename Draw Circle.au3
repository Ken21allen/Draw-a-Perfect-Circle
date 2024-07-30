#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author: Kenny Allen Christopher Abrahams

 Script Function: Automatically draw a perfect circle on https://neal.fun/perfect-circle/
#ce ----------------------------------------------------------------------------

HotKeySet("^k", "StartDrawing") ; Set "Ctrl + K" as the hotkey to start drawing
HotKeySet("{ESC}", "StopDrawing") ; Set "Esc" as the hotkey to stop drawing

Global $pi = 3.14
Global $rad = 200 ;Radius of the circle in pixels
Global $timeCirc = 360 / 50 ;Calculate the time to complete one full circle considering 50 steps to make a complete circle
Global $sE = 0.40 ;Small tolerance value to determine the end of the loop
Global $drawing = False
Global $timer, $position

While True
    If $drawing Then
        DrawCircle()
    EndIf
    Sleep(10)
WEnd

Func StartDrawing()
    $drawing = True
    $position = MouseGetPos()
    $timer = TimerInit()
EndFunc

Func StopDrawing()
    $drawing = False
    MouseUp("left")
EndFunc

Func DrawCircle()
    $elapsedTime = TimerDiff($timer) / 1000 ; Calculate the elapsed time in seconds
    $ang = $elapsedTime * 50 ; Calculate the current angle based on elapsed time

    ; Calculate the new X and Y positions for the mouse using trigonometric functions
    $newX = $position[0] + $rad * Cos($ang * $pi / 180)
    $newY = $position[1] + $rad * Sin($ang * $pi / 180)

    MouseMove($newX, $newY)
    MouseDown("left")

    ; Exit the loop if the elapsed time is greater than or equal to the time to complete one full circle minus the small tolerance
    If $elapsedTime >= ($timeCirc - $sE) Then
        StopDrawing()
    EndIf
EndFunc

