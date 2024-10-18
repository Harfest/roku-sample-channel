sub init()
    m.imdbService = createObject("roSGNode", "IMDBService")
    m.imdbService.callFunc("getNowPlaying")
end sub

function onKeyEvent(key as String, pressed as boolean) as Boolean
    handled = false
    ?"Key pressed on Page A " pressed
    if not pressed then return handled


    ' if key = "right"
    '     pressed = true
    '     ' Navigate to Page B
    '     m.global.navigateTo = {
    '         page: "PageB"
    '     }
    '     handled = true
    ' end if

    return handled
end function