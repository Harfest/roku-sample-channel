sub init()
    m.content = invalid

    setupRefs()
end sub

sub setupRefs()
    top = m.top
    m.poster = top.findNode("itemPoster")
end sub

sub contentChanged(evt as object)
    m.content = evt.getData()

    setupPoster()
    ' id: "1075676"
    ' adult: false
    ' backdropPath: "https://image.tmdb.org/t/p/original/64tinBsds1nVp4wOCgYhMbSgsRW.jpg"
    ' originalLanguage: "ko"
    ' originalTitle: "전,란"
    ' overview: "In the Joseon Dynasty, two friends who grew up together — one the master and one the servant — reunite post-war as enemies on opposing sides."
    ' popularity: 850.531
    ' posterPath: "https://image.tmdb.org/t/p/original/hg9OeaCRSpazrfqYyEFr6BDaZW8.jpg"
    ' releaseDate: "2024-10-02"
    ' title: "Uprising"
    ' video: false
    ' videoUrl: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_1MB.mp4"
    ' voteAverage: 7.3
    ' voteCount: 62
end sub

sub setupPoster()
    m.poster.width = 258
    m.poster.height = 368
    m.poster.uri = m.content.posterPath
end sub
