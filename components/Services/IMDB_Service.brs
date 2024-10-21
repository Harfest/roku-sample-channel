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

function getImageUrl(imgPath as String)
    baseImageUrl = m.appInfo.getValue("base_img_url")
    return baseImageUrl + imgPath
end function

function getBackdropImageUrl(imgPath as String)
    baseImageUrl = m.appInfo.getValue("base_backdrop_img_url")
    return baseImageUrl + imgPath
end function

sub getNowPlaying()
    ' I need to process this url in case I receive some args (like a movie id)
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
            itemNode.backdropPath = getBackdropImageUrl(item.backdrop_path)
            itemNode.videoId = StrI(item.id).replace(" ", "") ' Transform the id to a string
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

sub onGetMovieByIdChanged(res as object)
    data = res.getData()

    movieModel = createObject("roSGNode", "MovieModel")

    movieModel.adult = data.adult
    movieModel.backdropPath = getBackdropImageUrl(data.backdrop_path)
    movieModel.belongsToCollection = data.belongs_to_collection
    movieModel.budget = data.budget
    movieModel.genres = data.genres
    movieModel.homepage = data.homepage
    movieModel.movieId = data.id
    movieModel.imdbId = data.imdb_id
    movieModel.originCountry = data.origin_country
    movieModel.originalLanguage = data.original_language
    movieModel.originalTitle = data.original_title
    movieModel.overview = data.overview
    movieModel.popularity = data.popularity
    movieModel.posterPath = getImageUrl(data.poster_path)
    movieModel.productionCompanies = data.production_companies
    movieModel.productionCountries = data.production_countries
    movieModel.releaseDate = data.release_date
    movieModel.revenue = data.revenue
    movieModel.runtime = data.runtime
    movieModel.spokenLanguages = data.spoken_languages
    movieModel.status = data.status
    movieModel.tagline = data.tagline
    movieModel.title = data.title
    movieModel.video = data.video
    movieModel.voteAverage = data.vote_average
    movieModel.voteCount = data.vote_count

    m.top.movieById = movieModel
end sub
