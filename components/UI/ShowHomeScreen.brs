sub ShowHomeScreen()
    m.HomeScreen=CreateObject("roSGNode","HomeScreen")
    m.HomeScreen.ObserveField("btnHomeSelected","onbtnHomeSelected")

    ShowScreen(m.HomeScreen)

    


end sub