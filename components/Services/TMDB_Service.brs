function getBaseUrl()
    appInfo = CreateObject("roAppInfo")
    baseUrl = appInfo.getValue("base_url")
    apiKey = appInfo.getValue("api_key")

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

function getNowPlaying()
    url = getPathAsUrl("nowPlaying")

    ?"Preparing to request to " url

    readInternet = CreateObject("roURLTransfer")
    readInternet.setUrl(url)
    readInternet.SetCertificatesFile("common:/certs/ca-bundle.crt")
    contentStr = readInternet.GetToString()
    content = ParseJson(contentStr)
    return content
end function

function getMovieById(id)
    url = getPathAsUrl("movieDetails", [id])

    ?"Preparing to request to " url

    readInternet = CreateObject("roURLTransfer")
    readInternet.setUrl(url)
    readInternet.SetCertificatesFile("common:/certs/ca-bundle.crt")
    contentStr = readInternet.GetToString()
    content = ParseJson(contentStr)
    return content
end function

' <?xml version="1.0" encoding="utf-8" ?>
' <component name="IMDBService" extends="Group">
'     <interface>
'         <function name="getNowPlaying"/>
'         <function name="getMovieById"/>
'     </interface>
' 	<script type="text/brightscript" uri="pkg:/components/Services/IMDB_Service.brs"></script>
' </component>
