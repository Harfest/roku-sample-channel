sub init()
    m.appInfo = CreateObject("roAppInfo")
    m.IMDBTask = CreateObject("roSGNode", "IMDBTask")
end sub

function getBaseUrl()
    baseUrl = m.appInfo.getValue("base_url")
    apiKey = m.appInfo.getValue("api_key")

    return baseUrl + "{0}?api_key=" + apiKey
end function

function getPathAsUrl(path as String)

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

    return substitute(baseUrl, urlPath)
end function

function getImageUrl(imgPath as String)
    baseImageUrl = m.appInfo.getValue("base_img_url")
    return baseImageUrl + imgPath
end function

function getNowPlaying()
    ' I need to process this url in case I receive some args (like a movie id)
    url = getPathAsUrl("nowPlaying")

    ?"Preparing to request to " url

    m.IMDBTask.observeField("content", "onNowPlayingContentChanged")
    m.IMDBTask.contentUri = url
    m.IMDBTask.control = "RUN"
end function

sub onNowPlayingContentChanged(res as object)
    data = res.getData()
    resultsCollection = data.results

    contentNode = createObject("roSGNode", "ContentNode")

    totalRows = resultsCollection.count() / 5

    itemIndex = 0
    for x = 0 to totalRows - 1
        rowNode = createObject("roSGNode", "ContentNode")
        rowNode.title = "Row " + StrI(x + 1)

        for y = 1 to 5
            itemNode = createObject("roSGNode", "ItemModel")
            item = resultsCollection[itemIndex]

            itemNode.adult = item.adult
            itemNode.backdropPath = getImageUrl(item.backdrop_path)
            itemNode.id = item.id
            itemNode.originalLanguage = item.original_language
            itemNode.originalTitle = item.original_title
            itemNode.overview = item.overview
            itemNode.popularity = item.popularity
            itemNode.posterPath = getImageUrl(item.poster_path)
            itemNode.releaseDate = item.release_date
            itemNode.title = item.title
            itemNode.video = item.video
            itemNode.voteAverage = item.vote_average
            itemNode.voteCount = item.vote_count
            itemNode.videoUrl = "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_1MB.mp4"
            rowNode.appendChild(itemNode)
            itemIndex++
        end for

        contentNode.appendChild(rowNode)
    end for

    m.top.nowPlayingContent = contentNode
end sub
