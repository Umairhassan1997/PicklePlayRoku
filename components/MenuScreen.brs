sub init()
  ?"ttt"
      m.navBar=m.top.findNode("navBar")
   navBarInit("Home")
      m.top.observeField("visible","onVisibleChange")

    m.btnChannels=m.top.findNode("btnChannels")
    m.btnMovies=m.top.findNode("btnMovies")
    m.btnSeries=m.top.findNode("btnSeries")
    m.btnPlaylist=m.top.findNode("btnPlaylist")
    m.btnLink=m.top.findNode("btnLink")
    
    m.readMarkupGridTask = createObject("roSGNode", "appSettingsData")
    m.readMarkupGridTask.inputUrl=getCurrentLink()
m.readMarkupGridTask.observeField("content", "onContent")
m.readMarkupGridTask.control = "RUN"


    
   m.busyspinner = m.top.findNode("menuSpinner")
   m.busyspinner.poster.observeField("loadStatus", "showspinner")
   m.busyspinner.poster.uri = "pkg:/images/loader.png"
   screenWidth = 1920
    screenHeight = 1080

    posterWidth = m.busyspinner.poster.width
    posterHeight = m.busyspinner.poster.height

    ' Calculate center position
    x = (screenWidth - posterWidth) / 2
    y = (screenHeight - posterHeight) / 2

    m.busyspinner.poster.translation = [x, y]

    if isUserFirstVisit()
      ?"oiu2"

      m.oneTimeMessage=  CreateObject("roSGNode", "Dialog")
      m.oneTimeMessage.title="Disclaimer"
      m.oneTimeMessage.message="IPTV Stream Player does not provide or stream any media content of its own. This app is a media player only. You must add your own content or playlist (such as M3U or HLS) from a legal IPTV service provider. We do not host, promote, or sell any copyrighted content. By using this app, you agree that you are solely responsible for the content you load and stream."
      m.oneTimeMessage.buttons=["OK"]
      m.oneTimeMessage.observeField("buttonSelected","onDialogButtonSelect")
      
      m.top.getScene().dialog=m.oneTimeMessage


    end if


end sub

sub onDialogButtonSelect()
  if m.oneTimeMessage.buttonSelected=0
    m.oneTimeMessage.close=true

  end if

end sub

function getCurrentLink()
    sec=CreateObject("roRegistrySection",m.global.appName)
    


    if sec.Exists("currentURL")
        currentURL=sec.Read("currentURL")
        return currentURL
    end if
    return ""

    end function

sub onContent()
    
    m.busyspinner.visible=false
    m.btnChannels.setFocus(true)
    m.global.channelsArray=m.readMarkupGridTask.content

end sub

 function OnkeyEvent(key as string, press as boolean) as boolean

    result = false

    if press
        if key="right" and m.btnChannels.hasFocus()
            m.btnChannels.setFocus(false)
            m.btnMovies.setFocus(true)
            return true
        else if key="right" and m.btnMovies.hasFocus()
            m.btnMovies.setFocus(false)
            m.btnSeries.setFocus(true)
            return true
            else if key="down" and m.btnMovies.hasFocus()
            m.btnMovies.setFocus(false)
            m.btnPlaylist.setFocus(true)
            return true
            else if key="up" and m.btnPlaylist.hasFocus()
            m.btnPlaylist.setFocus(false)
            m.btnMovies.setFocus(true)
            return true
            else if key="right" and m.btnSeries.hasFocus()
            m.btnSeries.setFocus(false)
            m.btnPlaylist.setFocus(true)
            return true
             else if key="down" and m.btnSeries.hasFocus() and m.scene.isSubscribed=false
            m.btnSeries.setFocus(false)
            m.btnLink.setFocus(true)
            return true
            else if key="up" and m.btnLink.hasFocus()
            m.btnLink.setFocus(false)
            m.btnSeries.setFocus(true)
            return true
            else if key="right" and m.btnPlaylist.hasFocus() and m.scene.isSubscribed=false
            m.btnPlaylist.setFocus(false)
            m.btnLink.setFocus(true)
            return true
            else if key="left" and m.btnLink.hasFocus()
            m.btnLink.setFocus(false)
            m.btnPlaylist.setFocus(true)
            return true
            else if key="left" and m.btnPlaylist.hasFocus()
            m.btnPlaylist.setFocus(false)
            m.btnSeries.setFocus(true)
            return true
            else if key="left" and m.btnSeries.hasFocus()
            m.btnSeries.setFocus(false)
            m.btnMovies.setFocus(true)
            return true
            else if key="left" and m.btnMovies.hasFocus()
            m.btnMovies.setFocus(false)
            m.btnChannels.setFocus(true)
            return true

             else if key="left" and m.btnChannels.hasFocus()
      m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoUF.png"
      m.btnChannels.setFocus(false)
      m.btnHomeN.setFocus(true)
      return true
       else if key="right" and (m.btnHomeN.hasFocus() or m.btnSearchN.hasFocus() or m.btnPlaylistN.hasFocus() or m.btnFavN.hasFocus() or m.btnInputN.hasFocus() or m.btnSettingN.hasFocus())
      m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoF.png"
      m.top.setFocus(false)
      m.btnChannels.setFocus(true)
      return true
      else if key="down" and m.btnSearchN.hasFocus()
        m.btnSearchN.setFocus(false)
      m.btnHomeN.setFocus(true)
      return true
      else if key="down" and m.btnHomeN.hasFocus()
        m.btnHomeN.setFocus(false)
      m.btnPlaylistN.setFocus(true)
      return true
      else if key="down" and m.btnPlaylistN.hasFocus()
        m.btnPlaylistN.setFocus(false)
      m.btnFavN.setFocus(true)
      return true
      else if key="down" and m.btnFavN.hasFocus()
        m.btnFavN.setFocus(false)
      m.btnInputN.setFocus(true)
      return true
      else if key="down" and m.btnInputN.hasFocus()
        m.btnInputN.setFocus(false)
      m.btnSettingN.setFocus(true)
      return true
      else if key="up" and m.btnHomeN.hasFocus()
        m.btnHomeN.setFocus(false)
      m.btnSearchN.setFocus(true)
      return true
      else if key="up" and m.btnPlaylistN.hasFocus()
        m.btnPlaylistN.setFocus(false)
      m.btnHomeN.setFocus(true)
      return true
      else if key="up" and m.btnFavN.hasFocus()
        m.btnFavN.setFocus(false)
      m.btnPlaylistN.setFocus(true)
      return true
      else if key="up" and m.btnInputN.hasFocus()
        m.btnInputN.setFocus(false)
      m.btnFavN.setFocus(true)
      return true
      else if key="up" and m.btnSettingN.hasFocus()
        m.btnSettingN.setFocus(false)
      m.btnInputN.setFocus(true)
      return true

        end if

    end if

    end function

    sub onVisibleChange()
        if m.top.visible
          ?"555ttt"
          navBarInit("Home")
            m.btnChannels.setFocus(true)
        end if

    end sub

   function isUserFirstVisit()
    sec = CreateObject("roRegistrySection","IPTV_Player")
    if sec.Exists("isUserFirstVisit")
        return false
    else
      sec.Write("isUserFirstVisit","true")
        return true

    end if

    end function

  