sub init()
    InitScreenStack()
    m.top.AppLimit=7
    m.routedOnLaunch=false
    InitUsageTimer()
    m.global.launchRoutePending=true
    m.global.AddField("m3uLink","string",false)
    m.btnGS=m.top.findNode("btnGS")
    m.btnTac=m.top.findNode("btnTac")
    m.btnWT=m.top.findNode("btnWT")
    m.landingGroup=m.top.findNode("landingGroup")
    m.launchSpinner=m.top.findNode("launchSpinner")
    m.splashBackground=m.top.findNode("splashBackground")
    m.launchSpinner.poster.uri="pkg:/images/loader.png"
    showLaunchSplash()
    VerifySubscription()
    m.global.m3uLink=""
    m.global.AddField("appName","string",false)
    m.global.AddField("appLaunchCount","integer",false)
    m.global.AddField("channelsArray","array",false)
    m.global.AddField("playlistArray","array",false)
    m.global.appName="IPTV"
    m.global.AddField("isFirstUse","boolean",false)
    m.global.isFirstUse=true
    m.top.Mac=GetMacAddressFromDeviceId()
      m.video = m.top.findNode("videoPlayer")
      m.video.observeField("state","onVideoState")
      m.btnGS.ObserveField("buttonSelected","onbtnStartScreenSelect")
      m.btnTac.ObserveField("buttonSelected","onbtntacSelec")
      m.btnWT.ObserveField("buttonSelected","onbtnWTselected")

    m.videoPlayer2 = CreateObject("roSGNode", "ContentNode")
    m.videoPlayer2.url = "https://cdn.jsdelivr.net/gh/shahzain888/JsonCDN@main/ADD.mp4"
    m.videoPlayer2.streamformat = "mp4"
    m.videoPlayer2.title="Intoduction"
    m.video.content = m.videoPlayer2
  

    sec = CreateObject("roRegistrySection", m.global.appName)
    if sec.Exists("AppCount")
        appCount=sec.Read("AppCount").toInt()
        sec.Write("AppCount",(appCount+1).toStr())

    else
        sec.Write("AppCount","1")
        ' Intro video skipped — launch routes to Live TV after subscription check
    end if
    
    m.global.appLaunchCount=sec.Read("AppCount").toStr().toInt()
    ?"AppLaunchCount"m.global.appLaunchCount

       


end sub

sub onVideoState()
    if m.video.state="finished"
         m.video.control="stop"
            m.video.visible=false
            m.btnWT.SetFocus(true)

    end if

end sub

sub onbtnWTselected()
       m.video.control = "play"
       m.video.visible=true
    m.video.setFocus(true)

end sub

sub onbtntacSelec()
     m.oneTimeMessage=  CreateObject("roSGNode", "Dialog")
      m.oneTimeMessage.title="Disclaimer"
      m.oneTimeMessage.message="IPTV Stream Player does not provide or stream any media content of its own. This app is a media player only. You must add your own content or playlist (such as M3U or HLS) from a legal IPTV service provider. We do not host, promote, or sell any copyrighted content. By using this app, you agree that you are solely responsible for the content you load and stream."
      m.oneTimeMessage.buttons=["Close"]
      m.oneTimeMessage.observeField("buttonSelected","onDialogButtonSelect")
      
      m.top.dialog=m.oneTimeMessage

end sub

sub onDialogButtonSelect()
  if m.oneTimeMessage.buttonSelected=0
    m.oneTimeMessage.close=true

  end if

end sub



sub onbtnStartScreenSelect()
    sec = CreateObject("roRegistrySection", m.global.appName)
    if sec.Exists("URL")
        ShowMenuScreen()
    else
        ShowInputScreen()

    end if

end sub

sub RedirectToScreen()
     sec = CreateObject("roRegistrySection", m.global.appName)
    if sec.Exists("URL")
        ShowMenuScreen()
    else
        ShowInputScreen()

    end if

end sub

function OnKeyEvent(key as string, press as boolean) as boolean
   result = false
   if press
       ' handle "back" key press
       if key = "back" and m.video.hasFocus()=false
           ?"Back Pressed Event in MainScene"
           numberOfScreens = m.screenStack.Count()
           ?"number of screens"numberOfScreens
           ' close top screen if there are two or more screens in the screen stack
           if numberOfScreens > 1
           

               CloseScreen(invalid)
               result = true
           

           end if

        else if key="back" and m.video.hasFocus()
            m.video.control="stop"
            m.video.visible=false
            m.btnWT.SetFocus(true)
            return true

        else if key="down" and (m.btnGS.hasFocus() or m.btnWT.hasFocus())
            m.btnGS.SetFocus(false)
            m.btnTac.SetFocus(true)
            result=true
            else if key="right" and m.btnGS.hasFocus()
            m.btnGS.SetFocus(false)
            m.btnWT.SetFocus(true)
            result=true
            else if key="left" and m.btnWT.hasFocus()
            m.btnWT.SetFocus(false)
            m.btnGS.SetFocus(true)
            result=true

             else if key="up" and m.btnTac.hasFocus()
            m.btnTac.SetFocus(false)
            m.btnGS.SetFocus(true)
            result=true


       end if
   end if
 
   return result
end function

function GetMacAddressFromDeviceId() as String
    deviceInfo = CreateObject("roDeviceInfo")
    uniqueId = deviceInfo.GetChannelClientId() ' e.g., "1234567890abcdef1234567890abcdef"

    ' Take last 12 hex characters (6 bytes)
    hexPart = Right(uniqueId, 12) ' e.g., "90abcdef1234"

    ' Format as MAC: XX:XX:XX:XX:XX:XX
    macAddress = UCase(Left(hexPart, 2)) + ":" + UCase(Mid(hexPart, 3, 2)) + ":" + UCase(Mid(hexPart, 5, 2)) + ":" + UCase(Mid(hexPart, 7, 2)) + ":" +               UCase(Mid(hexPart, 9, 2)) + ":" + UCase(Right(hexPart, 2))

    return macAddress
end function

sub CallMenuScreen()
    m.screenStack=[]
        ShowMenuScreen()
    

end sub

' Routes free/pro users to Live TV or paywall after splash + subscription check
sub RouteOnLaunch()
    if m.routedOnLaunch=true
        return
    end if
    m.routedOnLaunch=true
    hideLaunchSpinner()

    if m.video<>invalid and m.video.visible
        m.video.control="stop"
        m.video.visible=false
    end if

    if isUserPro()
        ShowLivePlayerScreen()
    else if GetRemainingSeconds()<=0
        ShowSubscriptionScreen()
    else
        ShowLivePlayerScreen()
    end if
end sub

sub hideLandingUi()
    if m.landingGroup<>invalid
        m.landingGroup.visible=false
    end if
end sub

sub showLandingUi()
    hideLaunchSplash()
    if m.landingGroup<>invalid
        m.landingGroup.visible=true
        m.btnGS.SetFocus(true)
    end if
end sub

sub showLaunchSplash()
    if m.splashBackground<>invalid
        m.splashBackground.visible=true
    end if
    hideLandingUi()
    showLaunchSpinner()
end sub

sub hideLaunchSplash()
    if m.splashBackground<>invalid
        m.splashBackground.visible=true
    end if
    hideLaunchSpinner()
end sub

sub showLaunchSpinner()
    if m.launchSpinner<>invalid
        m.launchSpinner.visible=true
    end if
end sub

sub hideLaunchSpinner()
    if m.launchSpinner<>invalid
        m.launchSpinner.visible=false
    end if
end sub