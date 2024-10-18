sub init()
    m.top.functionName = "getContent"
    m.top.observeField("state", "onStateChanged")
end sub

sub getContent()
    readInternet = CreateObject("roURLTransfer")
    readInternet.setUrl(m.top.contentUri)
    readInternet.SetCertificatesFile("common:/certs/ca-bundle.crt")
    contentStr = readInternet.GetToString()
    content = ParseJson(contentStr)
    m.top.content = content
end sub

sub onStateChanged(evt as object)
    data = evt.getData()
    ?"Task state: " data
end sub
