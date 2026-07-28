sub ShowFavoriteScreen()
    m.FavoriteScreen=CreateObject("roSGNode","FavoriteScreen")
    m.FavoriteScreen.ObserveField("btnHomeSelected","onbtnHomeSelected")
    ShowScreen(m.FavoriteScreen)


end sub

sub onbtnHomeSelected()
    m.screenStack=[]
    ShowMenuScreen()

end sub