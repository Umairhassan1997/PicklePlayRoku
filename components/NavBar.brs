sub navBarInit(screenName as String)

    m.screenName=screenName
   m.scene= m.top.getScene()
    ?"Screen Name"m.screenName
    m.btnSearchN=m.top.findNode("btnSearchN")
    m.btnHomeN=m.top.findNode("btnHomeN")
    m.btnPlaylistN=m.top.findNode("btnPlaylistN")
    m.btnFavN=m.top.findNode("btnFavN")
    m.btnInputN=m.top.findNode("btnInputN")
    m.btnSettingN=m.top.findNode("btnSettingN")
   if m.screenName<>"Search"
    ?"NB1"
    m.btnSearchN.observeField("buttonSelected","ShowSearchScreen")
   else
    m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaF.png"

   end if
   if  m.screenName<>"Home"
    ?"NB2"
    m.btnHomeN.observeField("buttonSelected","ShowMenuScreen")
     else
    m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoF.png"

   end if

   if m.screenName<>"Playlist"
    ?"NB3"
    m.btnPlaylistN.observeField("buttonSelected","ShowPlaylistScreen")
   else
        m.btnPlaylistN.focusfootprintbitmapuri="pkg:/images/btnPlF.png"

   end if
   if m.screenName<>"Fav"
    ?"NB4"
    m.btnFavN.observeField("buttonSelected","ShowFavoriteScreen")

   else
        m.btnFavN.focusfootprintbitmapuri="pkg:/images/btnFavF.png"

   end if

   if m.screenName<>"Input"
    ?"NB5"
    m.btnInputN.observeField("buttonSelected","ShowInputScreen")
   else
        m.btnInputN.focusfootprintbitmapuri="pkg:/images/btnIpF.png"

   end if

   if m.screenName<>"Setting"
    ?"NB5"
    m.btnSettingN.observeField("buttonSelected","ShowSettingScreen")

   else
        m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetF.png"


   end if

'    m.scene=m.top.getScene()


end sub

sub ShowSearchScreen()
    
     if m.scene.isSubscribed=false and m.global.appLaunchCount>m.scene.AppLimit
               ShowDialogToUser()
            else
    m.scene.callFunc("ShowSearchScreen")

            end if
    m.btnSearchN.unobserveField("buttonSelected")

end sub
sub ShowHomeScreen()
     if m.scene.isSubscribed=false and m.global.appLaunchCount>m.scene.AppLimit
                ShowDialogToUser()

            else
    m.scene.callFunc("ShowHomeScreen")

            end if
    m.btnHomeN.unobserveField("buttonSelected")

end sub
sub ShowPlaylistScreen()
     if m.scene.isSubscribed=false and m.global.appLaunchCount>m.scene.AppLimit
               ShowDialogToUser()

            else

    m.scene.callFunc("ShowPlaylistScreen")

            end if
    m.btnPlaylistN.unobserveField("buttonSelected")

end sub

sub ShowFavoriteScreen()
     if m.scene.isSubscribed=false and m.global.appLaunchCount>m.scene.AppLimit
               ShowDialogToUser()

            else
    m.scene.callFunc("ShowFavoriteScreen")
            end if
    m.btnFavN.unobserveField("buttonSelected")

end sub

sub ShowSettingScreen()
    m.scene.callFunc("ShowSettingScreen")
    m.btnSettingN.unobserveField("buttonSelected")

end sub



sub ShowInputScreen()
    if m.scene.isSubscribed=false and m.global.appLaunchCount>m.scene.AppLimit
                ShowDialogToUser()

            else
    
    m.scene.callFunc("ShowInputNavScreen")

            end if
    m.btnInputN.unobserveField("buttonSelected")

end sub

sub ShowMenuScreen()

    m.scene.callFunc("ShowMenuScreen")
    m.btnHomeN.unobserveField("buttonSelected")

end sub

sub ShowSubscriptionScreen()
    ?"dialog55"m.subscriptionDialog
if m.subscriptionDialog.buttonSelected=0

        m.subscriptionDialog.close=true
    m.scene.callFunc("ShowSubscriptionScreen")

end if


end sub

sub ShowDialogToUser()
    m.subscriptionDialog = createObject("roSGNode", "StandardMessageDialog")
    m.subscriptionDialog.title = "Subscribe Now to Watch"
    m.subscriptionDialog.message = ["You need subscription to Continue Watching these channels."]
    m.subscriptionDialog.buttons = ["OK"]

    ' observe the dialog's buttonSelected field to handle button selections
    m.subscriptionDialog.observeField("buttonSelected", "ShowSubscriptionScreen")

    m.scene.dialog = m.subscriptionDialog


end sub