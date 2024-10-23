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
    m.sampleHero = top.findNode("sampleHero")

    ' Animation
    m.rowAnimation = top.findNode("rowOpacityAnimation")
    m.heroAnimation = top.findNode("heroOpacityAnimation")
end sub

sub setupObservers()
    m.tmdbService.observeField("nowPlayingContent", "nowPlayingContentChanged")
    m.sampleHero.observeFieldScoped("loadStatus", "onHeroLoadStatusChanged")
    m.rowList.observeField("rowItemSelected", "onRowListItemSelected")
    m.rowList.observeField("rowItemFocused", "onRowItemFocused")
end sub

sub onScreenEnter()
    ? "Screen Page A entered"
    if m.content <> invalid
        m.rowAnimation.control = "start"
        m.heroAnimation.control = "start"
        m.initialFocusNode.setFocus(true)
    end if
end sub

sub nowPlayingContentChanged(data)
    m.content = data.getData()
    rowsData = m.content
    m.rowList.content = rowsData

    m.rowAnimation.control = "start"

    m.rowList.setFocus(true)
end sub

function getRowItem(rowItemCoordinates)
    selectedRowIndex = rowItemCoordinates[0]
    selectedColumnIndex = rowItemCoordinates[1]

    ' Get the row
    selectedRow = m.content.getChild(selectedRowIndex)
    ' get by the column
    selectedItem = selectedRow.getChild(selectedColumnIndex)

    return selectedItem
end function

sub onRowListItemSelected(evt as object)
    rowItemSelected = evt.getData()
    selectedItem = getRowItem(rowItemSelected)

    movieId = selectedItem.videoId

    m.rowList.opacity = 0.0
    m.sampleHero.opacity = 0.0

    m.global.navigateTo = {
        page: "DetailsPage",
        initData: {
            movieId: movieId
        }
    }
end sub

sub onRowItemFocused(evt as object)
    rowItemFocused = evt.getData()
    focusedItem = getRowItem(rowItemFocused)

    m.sampleHero.uri = focusedItem.backdropPath
end sub

sub onHeroLoadStatusChanged(evt as object)
    loadStatus = evt.getData()

    if loadStatus = "ready"
        m.heroAnimation.control = "start"
    end if
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