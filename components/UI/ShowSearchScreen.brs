sub ShowSearchScreen()
    m.SearchScreen=CreateObject("roSGNode","SearchScreen")
    m.SearchScreen.ObserveField("btnHomeSelected","onbtnHomeSelected")

    ShowScreen(m.SearchScreen)


end sub