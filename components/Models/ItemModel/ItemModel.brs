sub processModel()
    itemContent = m.top.modelContent
    item = itemContent.data

    m.top.adult = item.adult
    m.top.backdropPath = getBackdropImageUrl(item.backdrop_path)
    m.top.videoId = StrI(item.id).replace(" ", "") ' Transform the id field to a string
    m.top.originalLanguage = item.original_language
    m.top.originalTitle = item.original_title
    m.top.overview = item.overview
    m.top.popularity = item.popularity
    m.top.posterPath = getImageUrl(item.poster_path)
    m.top.releaseDate = item.release_date
    m.top.title = item.title
    m.top.video = item.video
    m.top.voteAverage = item.vote_average
    m.top.voteCount = item.vote_count
    m.top.videoUrl = "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_1MB.mp4"
end sub
