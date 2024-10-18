sub init()
    m.global.addFields({
        navigateTo: {}
    })
    ' Router initialization
    initRouter()
    ' Setup observers
    setupObservers()

    ' Setup router outlet
    setupRouterOutlet()

    ' Navigate to Page A/Initial page
    navigateToHome()
end sub

sub setupObservers()
    m.global.observeField("navigateTo", "navigate")
end sub

sub setupRouterOutlet()
    di = createObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    displayWidth = displaySize.w
    displayHeight = displaySize.h

    m.routerOutlet.width = displayWidth
    m.routerOutlet.height = displayHeight
end sub

' function onKeyEvent(key as string, pressed as boolean) as boolean
'     handled = false
'     ?"Key presed on Main Scene " pressed
'     if not pressed then return handled
'     return handled
' end function
