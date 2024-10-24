sub init()
    m.top.functionName = "getContent"
    m.top.observeField("state", "onStateChanged")
end sub

sub getContent()
end sub

sub onStateChanged(evt as object)
    data = evt.getData()
    ?"Task state: " data
end sub

sub setupTask()
end sub
