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

    ' HttpTask is another option to handle request more specifically
    ' it adds headers, methods and more details in a more 'friendly' way 
    ?"Preparing to request to " url
    ' https://developer.roku.com/es-mx/docs/references/scenegraph/list-and-grid-nodes/rowlist.md#rowlist-xml-component

    m.IMDBTask.observeField("content", "onContentChanged")
    m.IMDBTask.contentUri = url
    m.IMDBTask.control = "RUN"
end function

sub onContentChanged(res as object)
    data = res.getData()

    ' The content should be a single ContentNode that has one child ContentNode for each row.
    ' Process data to create an assoc array that saves everything what we need
    ?"Result: " data
end sub
