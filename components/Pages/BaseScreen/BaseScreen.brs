sub init()
    m.top.enableRenderTracking = true
    m.top.observeField("renderTracking", "renderTracker")
end sub

sub renderTracker(evt as object)
    renderTrack = evt.getData()
    if renderTrack = "full"
        onScreenEnter()
    end if
end sub

' Override on each screen
sub onScreenEnter()
end sub