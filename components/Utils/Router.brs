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
    homePage = createObject("roSGNode", "PageA")
    m.stack.push(homePage)

    m.routerOutlet.appendChild(homePage)
    homePage.setFocus(true)
end sub

sub navigate(event as object)
    navigationData = event.getData()
    navPage = navigationData.page

    ' Create a reference to the new screen and push it to the stack
    newPage = CreateObject("RoSGNode", navPage)

    ' Push the reference to the stack
    m.stack.push(newPage)

    ' Remove the child of the router outlet
    m.routerOutlet.removeChildIndex(0)

    ' Place the new screen as child of the router outlet
    m.routerOutlet.appendChild(newPage)

    ' Focus on the new screen
    newPage.setFocus(true)
end sub
