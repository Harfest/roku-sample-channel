sub init()
    m.content = invalid
    m.tmdbService = createObject("roSGNode", "IMDBService")

    setupRefs()

    setupObservers()

    m.initialFocusNode = m.detailsCtas
end sub

sub setupRefs()
    top = m.top
    m.bgPoster = top.findNode("bgPoster")
    m.titleLabel = top.findNode("movieTitle")
    m.movieDescription = top.findNode("movieDescription")
    m.detailsCtas = top.findNode("detailsCtas")
    m.videoPlayer = invalid

    ' Animations
    m.bgAnimation = top.findNode("bgOpacitAnimation")
    m.metadataOpacitAnimation = top.findNode("metadataOpacitAnimation")
    m.metadataTranslationAnimation = top.findNode("metadataTranslationAnimation")
end sub

sub setupObservers()
    m.tmdbService.observeField("movieById", "movieByIdChanged")
    m.detailsCtas.observeField("command", "onButtonPressed")
    m.top.observeField("initData", "initDataReceived")
end sub

sub initDataReceived(evt)
    initData = evt.getData()

    movieId = initData["movieId"]

    m.tmdbService.callFunc("getMovieById", movieId)
end sub

sub onScreenEnter()
    ? "Screen Page B entered"
    ' Attach the video node
    m.videoPlayer = createObject("roSGNode", "Video")
    m.videoPlayer.visible = false
    m.top.appendChild(m.videoPlayer)
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

    m.detailsCtas.setFocus(true)

    ' Prepare video data
    if m.videoPlayer <> invalid
        ' At this point the screen is already mounted and the m.videoPlayer is already set
        ' So this validation is JIC
        videoPlayerContent = createObject("RoSGNode", "ContentNode")

        videoPlayerContent.title = m.content.title
        videoPlayerContent.url = m.content.videoUrl
        videoPlayerContent.FHDPosterUrl = m.content.backdropPath
        videoPlayerContent.streamformat = "mp4"

        m.videoPlayer.content = videoPlayerContent

        m.videoPlayer.observeField("state", "onMovieProgressChanged")
    end if
end sub

' Once the bg is ready to be shown, show it
sub bgLoadStatusChanged(evt as object)
    loadStatus = evt.getData()
    if loadStatus = "ready"
        m.bgAnimation.control = "start"
    end if
end sub

sub onButtonPressed(evt as object)
    command = evt.getData()

    if command = "play"
        ' Lets start playing
        m.videoPlayer.visible = true
        m.videoPlayer.setFocus(true)
        m.videoPlayer.control = "play"
    else if command = "rate"
        ? "Open something to rate this movie"
    end if

end sub

sub onMovieProgressChanged(evt as object)
    status = evt.getData()

    if status = "finished"
        removePlayer()
    end if
end sub

sub removePlayer()
    ? "Remove player"
    m.videoPlayer.visible = false
    m.detailsCtas.setFocus(true)
end sub

function onKeyEvent(key as string, pressed as boolean) as boolean
    handled = false
    if not pressed then return handled

    if key = "back" and m.videoPlayer.visible = true
        removePlayer()
        handled = true
    else if key = "back"
        m.global.navigateTo = {
            page: "back",
        }
        handled = true
    end if

    return handled
end function
