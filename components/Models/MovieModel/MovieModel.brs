sub processModel()
    movieContent = m.top.modelContent
    movieData = movieContent.data

    m.top.adult = movieData.adult
    m.top.backdropPath = getBackdropImageUrl(movieData.backdrop_path)
    m.top.belongsToCollection = movieData.belongs_to_collection
    m.top.budget = movieData.budget
    m.top.genres = movieData.genres
    m.top.homepage = movieData.homepage
    m.top.movieId = StrI(movieData.id).replace(" ", "")
    m.top.imdbId = movieData.imdb_id
    m.top.originCountry = movieData.origin_country
    m.top.originalLanguage = movieData.original_language
    m.top.originalTitle = movieData.original_title
    m.top.overview = movieData.overview
    m.top.popularity = movieData.popularity
    m.top.posterPath = getImageUrl(movieData.poster_path)
    m.top.productionCompanies = movieData.production_companies
    m.top.productionCountries = movieData.production_countries
    m.top.releaseDate = movieData.release_date
    m.top.revenue = movieData.revenue
    m.top.runtime = movieData.runtime
    m.top.spokenLanguages = movieData.spoken_languages
    m.top.status = movieData.status
    m.top.tagline = movieData.tagline
    m.top.title = movieData.title
    m.top.video = movieData.video
    m.top.voteAverage = movieData.vote_average
    m.top.voteCount = movieData.vote_count
    m.top.videoUrl = "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_1MB.mp4"
end sub
