sub ShowSettingScreen()
    m.SettingScreen=CreateObject("roSGNode","SettingScreen")
    m.SettingScreen.ObserveField("btnHomeSelected","onbtnHomeSelected")
    ShowScreen(m.SettingScreen)


end sub

