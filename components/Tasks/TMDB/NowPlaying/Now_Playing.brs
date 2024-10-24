sub init()
end sub

sub getContent()
    res = getNowPlaying()
    
    content = createObject("roSGNode", "RowsModel")
    content.modelContent = {data: res.results}
    content.callFunc("processModel")

    m.top.content = content
end sub
