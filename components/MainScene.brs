sub init()
    m.global.addFields({
        navigateTo: {}
    })
    ' Router initialization
    initRouter()
    ' Setup observers
    setupObservers()

    centerContainer()

    ' Navigate to Page A/Initial page
    navigateToHome()
end sub

sub setupObservers()
    m.global.observeField("navigateTo", "navigate")
end sub

sub centerContainer()
    ' Center the container component
    di = createObject("roDeviceInfo")
    displaySize = di.GetDisplaySize()
    displayWidth = displaySize.w
    displayHeight = displaySize.h

    xTranslation = (displayWidth - m.routerOutlet.width) / 2
    yTranslation = (displayHeight - m.routerOutlet.height) / 2

    m.routerOutlet.translation = [xTranslation, yTranslation]

end sub

' function onKeyEvent(key as string, pressed as boolean) as boolean
'     handled = false
'     ?"Key presed on Main Scene " pressed
'     if not pressed then return handled
'     return handled
' end function
