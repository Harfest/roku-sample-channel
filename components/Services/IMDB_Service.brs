sub init()
    m.appInfo = CreateObject("roAppInfo")
    m.IMDBTask = CreateObject("roSGNode", "IMDBTask")
end sub

function getBaseUrl()
    baseUrl = m.appInfo.getValue("base_url")
    apiKey = m.appInfo.getValue("api_key")

    return baseUrl + "{0}?api_key=" + apiKey
end function

function getPathAsUrl(path as String, params = [])

    baseUrl = getBaseUrl()

    paths = {
        "nowPlaying": "/movie/now_playing",
        "popular": "/movie/popular",
        "topRated": "/movie/top_rated",
        "upcoming": "/movie/upcoming",
        "movieDetails": "/movie/{0}",
        "movieTrailers": "/movie/{0}/videos",
    }

    urlPath = paths[path]

    url = substitute(baseUrl, urlPath)

    ' This could become a better way to handle the multiple params
    if params.count() > 0
        url = substitute(url, params[0])
    end if

    return url
end function

sub getNowPlaying()
    url = getPathAsUrl("nowPlaying")

    ?"Preparing to request to " url

    m.IMDBTask.observeField("content", "onNowPlayingContentChanged")
    m.IMDBTask.contentUri = url
    m.IMDBTask.control = "RUN"
end sub

sub getMovieById(id)
    url = getPathAsUrl("movieDetails", [id])

    ?"Preparing to request to " url

    m.IMDBTask.observeField("content", "onGetMovieByIdChanged")
    m.IMDBTask.contentUri = url
    m.IMDBTask.control = "RUN"
end sub

sub onNowPlayingContentChanged(res as object)
    data = res.getData()
    resultsCollection = data.results

    contentNode = createObject("roSGNode", "RowsModel")
    contentNode.modelContent = {data: resultsCollection}
    contentNode.callFunc("processModel")

    m.top.nowPlayingContent = contentNode
end sub

sub onGetMovieByIdChanged(res as object)
    movieData = res.getData()

    movieModel = createObject("roSGNode", "MovieModel")
    movieModel.modelContent = {data: movieData}
    movieModel.callFunc("processModel")

    m.top.movieById = movieModel
end sub
