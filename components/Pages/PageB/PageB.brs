sub init()
    m.content = invalid
    m.tmdbService = createObject("roSGNode", "IMDBService")

    setupRefs()

    setupObservers()
end sub

sub setupRefs()
    top = m.top
    m.bgPoster = top.findNode("bgPoster")
    m.titleLabel = top.findNode("movieTitle")
    m.movieDescription = top.findNode("movieDescription")

    ' Animations
    m.bgAnimation = top.findNode("bgOpacitAnimation")
    m.metadataOpacitAnimation = top.findNode("metadataOpacitAnimation")
    m.metadataTranslationAnimation = top.findNode("metadataTranslationAnimation")
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

    ' Load the bg image
    m.bgPoster.observeFieldScoped("loadStatus", "bgLoadStatusChanged")
    m.bgPoster.uri = m.content.backdropPath

    ' Load the movie title
    m.titleLabel.font.size = 102
    m.titleLabel.text = m.content.title

    ' Load the movie description
    m.movieDescription.font.size = 27
    m.movieDescription.text = m.content.overview

    m.metadataOpacitAnimation.control = "start"
    m.metadataTranslationAnimation.control = "start"
end sub

sub bgLoadStatusChanged(evt as object)
    loadStatus = evt.getData()
    if loadStatus = "ready"
        m.bgAnimation.control = "start"
    end if
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
