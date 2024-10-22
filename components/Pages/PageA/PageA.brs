sub init()
    m.content = invalid
    m.tmdbService = createObject("roSGNode", "IMDBService")
    m.tmdbService.callFunc("getNowPlaying")

    setupRefs()

    setupObservers()

    m.initialFocusNode = m.rowList
end sub

sub setupRefs()
    top = m.top
    m.rowList = top.findNode("rowList")
end sub

sub setupObservers()
    m.tmdbService.observeField("nowPlayingContent", "nowPlayingContentChanged")
end sub

sub onScreenEnter()
    ? "Screen Page A entered"
    if m.content <> invalid
        m.initialFocusNode.setFocus(true)
    end if
end sub

sub nowPlayingContentChanged(data)
    m.content = data.getData()
    rowsData = m.content
    m.rowList.observeField("rowItemSelected", "onRowListItemSelected")
    m.rowList.content = rowsData

    m.rowList.setFocus(true)
end sub

sub onRowListItemSelected(evt as object)
    rowItemSelected = evt.getData()
    selectedRowIndex = rowItemSelected[0]
    selectedColumnIndex = rowItemSelected[1]

    ' Get the row
    selectedRow = m.content.getChild(selectedRowIndex)
    ' get by the column
    selectedItem = selectedRow.getChild(selectedColumnIndex)

    movieId = selectedItem.videoId

    m.global.navigateTo = {
        page: "PageB",
        initData: {
            movieId: movieId
        }
    }
end sub

function onKeyEvent(key as String, pressed as boolean) as Boolean
    handled = false
    if not pressed then return handled

    ?"Key pressed on Page A " key " " pressed

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