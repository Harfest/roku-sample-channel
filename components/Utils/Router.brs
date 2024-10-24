sub initRouter()
    ' create the history stack
    m.stack = []

    ' setup router outlet
    setupOutletNode()
end sub

sub setupOutletNode()
    top = m.top
    m.routerOutlet = top.findNode("routerOutlet")
end sub

sub navigateToHome()
    homePage = createObject("roSGNode", "HomeScreen")
    m.stack.push(homePage)

    m.routerOutlet.appendChild(homePage)
    homePage.setFocus(true)
    homePage.callFunc("onScreenEnter")
    m.top.signalBeacon("AppLaunchComplete")
end sub

sub navigate(event as object)
    navigationData = event.getData()
    initData = invalid
    navPage = navigationData.page

    if navPage = "back"
        navigateBack()
        return
    end if

    if navigationData.initData <> invalid
        initData = navigationData.initData
    end if

    ' Create a reference to the new screen and push it to the stack
    newPage = CreateObject("RoSGNode", navPage)

    ' Set the init data in case it exists
    if initData <> invalid
        newPage.initData = initData
    end if

    ' Push the reference to the stack
    m.stack.push(newPage)

    ' Remove the child of the router outlet or just make it invisible
    ' m.routerOutlet.removeChildIndex(0)
    prevPage = m.routerOutlet.getChild(m.routerOutlet.getChildCount() - 1)
    prevPage.visible = false

    ' Place the new screen as child of the router outlet
    m.routerOutlet.appendChild(newPage)
    newPage.callFunc("onScreenEnter")

    ' Focus on the new screen
    newPage.setFocus(true)
end sub

sub navigateBack()
    ' remove the peek of the stack
    m.stack.pop()

    ' remove from the view
    currPage = m.routerOutlet.getChild(m.routerOutlet.getChildCount() - 1)
    m.routerOutlet.removeChild(currPage)

    ' Focus on the prev page
    prevPage = m.routerOutlet.getChild(m.routerOutlet.getChildCount() - 1)
    prevPage.visible = true
    prevPage.callFunc("onScreenEnter")
end sub
