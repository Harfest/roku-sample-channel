sub init()
end sub

sub getContent()
    movieId = m.top.movieId
    res = getMovieById(movieId)
    
    movieModel = createObject("roSGNode", "MovieModel")
    movieModel.modelContent = {data: res}
    movieModel.callFunc("processModel")

    m.top.content = movieModel
end sub
