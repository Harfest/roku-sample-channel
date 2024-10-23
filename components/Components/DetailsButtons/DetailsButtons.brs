sub init()
    setupRefs()

    m.playButton.opacity = 1.0
    m.lastFocusedNode = "play"
end sub

sub setupRefs()
    top = m.top
    m.playButton = m.top.findNode("playButton")
    m.rateButton = m.top.findNode("rateButton")
end sub

function onKeyEvent(key as string, pressed as boolean) as boolean
    handled = false
    if not pressed then return false

    if key = "right" and m.lastFocusedNode = "play"
    end if

    if key = "right" and m.lastFocusedNode = "play"
        m.playButton.opacity = 0.6
        m.rateButton.opacity = 1.0
        m.lastFocusedNode = "rate"
        handled = true
    else if key = "left" and m.lastFocusedNode = "rate"
        m.playButton.opacity = 1.0
        m.rateButton.opacity = 0.6
        m.lastFocusedNode = "play"
        handled = true
    else if key = "OK"
        m.top.command = m.lastFocusedNode
        handled = true
    end if

    return handled
end function
