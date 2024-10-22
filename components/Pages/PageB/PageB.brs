sub init()
    m.content = invalid
    m.tmdbService = createObject("roSGNode", "IMDBService")

    setupRefs()

    setupObservers()
end sub

sub setupRefs()
    top = m.top
    m.bgPoster = top.findNode("bgPoster")
end sub

sub setupObservers()
    m.tmdbService.observeField("movieById", "movieByIdChanged")
    m.top.observeField("initData", "initDataReceived")
end sub

sub initDataReceived(evt)
    initData = evt.getData()

    movieId = initData["movieId"]

    m.tmdbService.callFunc("getMovieById", movieId)
end sub

sub onScreenEnter()
    ? "Screen Page B entered"
end sub

sub movieByIdChanged(evt as object)
    m.content = evt.getData()

    setupBackground()
end sub

sub setupBackground()
    m.bgPoster.uri = m.content.backdropPath
end sub

function onKeyEvent(key as string, pressed as boolean) as boolean
    handled = false
    if not pressed then return handled

    if key = "back"
        m.global.navigateTo = {
            page: "back",
        }
        handled = true
    end if

    return handled
end function
