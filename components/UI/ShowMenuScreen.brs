sub ShowMenuScreen()

    m.MenuScreen=CreateObject("roSGNode","MenuScreen")
    m.MenuScreen.ObserveField("btnChannelsSelected","onbtnChannelsSelected")
    m.MenuScreen.ObserveField("btnMoviesSelected","onbtnMoviesSelected")
    m.MenuScreen.ObserveField("btnSeriesSelected","onbtnSeriesSelected")
    m.MenuScreen.ObserveField("btnPlaylistSelected","ValidateandShowRecentScreen")
    m.MenuScreen.ObserveField("btnLinkSelected","ShowSubscriptionScreen")
     ShowScreen(m.MenuScreen)


end sub

sub ValidateandShowRecentScreen()
         if m.top.isSubscribed=false and m.global.appLaunchCount>m.top.AppLimit
               showUserDialog()

            else
                ShowRecentScreen()

            end if


end sub

sub closeDialgAndShowSubScreen()
          if m.subscriptionDialog.buttonSelected=0

        m.subscriptionDialog.close=true
        ShowSubscriptionScreen()
          end if

end sub


sub onbtnChannelsSelected()
    m.top.OptionSelected="Channels"
    ValidateAndLaunchHomeScreen()


end sub

sub onbtnMoviesSelected()
        m.top.OptionSelected="Movies"
        ValidateAndLaunchHomeScreen()


end sub
sub onbtnSeriesSelected()
        m.top.OptionSelected="Series"
        ValidateAndLaunchHomeScreen()


end sub

sub ValidateAndLaunchHomeScreen()
            if m.top.isSubscribed=false and m.global.appLaunchCount>m.top.AppLimit
               showUserDialog()

            else
                ShowHomeScreen()

            end if


end sub

sub showUserDialog()
        m.subscriptionDialog = createObject("roSGNode", "StandardMessageDialog")
        m.subscriptionDialog.title = "Subscribe Now to Watch"
        m.subscriptionDialog.message = ["You need subscription to Continue Watching these channels."]
        m.subscriptionDialog.buttons = ["OK"]

        ' observe the dialog's buttonSelected field to handle button selections
        m.subscriptionDialog.observeField("buttonSelected", "closeDialgAndShowSubScreen")

        m.top.dialog = m.subscriptionDialog

end sub

