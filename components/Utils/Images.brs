sub init()
    m.appInfo = CreateObject("roAppInfo")
end sub

function getImageUrl(imgPath as String)
    baseImageUrl = m.appInfo.getValue("base_img_url")
    return baseImageUrl + imgPath
end function

function getBackdropImageUrl(imgPath as String)
    baseImageUrl = m.appInfo.getValue("base_backdrop_img_url")
    return baseImageUrl + imgPath
end function
