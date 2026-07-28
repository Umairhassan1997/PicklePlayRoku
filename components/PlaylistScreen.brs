sub init()

    m.navBar=m.top.findNode("navBar")
   navBarInit("Playlist")
   m.FocusTimer=m.top.findNode("FocusTimer")
   m.FocusTimer.observeField("fire","setFocusonMessage")

    m.noContGroup=m.top.findNode("noContGroup")
     m.btnHome=m.top.findNode("btnHome")
    m.playlist=m.top.findNode("playlist")
    m.playlist.ObserveField("itemSelected","onGridItemSelected")
    m.playlistItems=GetUrls()
    m.loader=m.top.findNode("loader")
    m.busyspinner = m.top.findNode("playlistSpinner")
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
   m.top.observeField("visible","onVisibleChange")

      gridContent = CreateObject("roSGNode", "ContentNode")

    for each item in m.playlistItems
         itemNode = gridContent.createChild("SimpleRowListItemData")
            itemNode.videoTitle = item.name
            itemNode.url = item.url
        
    end for

    m.playlist.content=gridContent
   
    m.playlist.setFocus(true)
     if m.playlist.content.getchildCount()=0
      m.FocusTimer.control="fire"

    end if
    
end sub

sub setFocusonMessage()
  m.playlist.visible=false
  m.playlist.setFocus(false)
  m.noContGroup.visible=true
  m.btnHome.setFocus(true)

end sub

sub onVisibleChange()
  if m.top.visible
    navBarInit("Playlist")
    if m.playlist.content.getchildCount()=0
      m.btnPlaylistN.setFocus(true)
    else
    m.playlist.setFocus(true)
    end if
  end if

 end sub

sub onGridItemSelected(evt)
    m.selectedIndex=evt.getData()
    
    
    m.readMarkupGridTask = createObject("roSGNode", "appSettingsData")
    m.readMarkupGridTask.inputUrl=m.playlist.content.getChild(m.selectedIndex).url
    ?"Current URL to extract"m.readMarkupGridTask.inputUrl
m.readMarkupGridTask.observeField("content", "onContent")
m.readMarkupGridTask.control = "RUN"
m.playlist.setFocus(false)

end sub

sub onContent()
  m.global.playlistArray=m.readMarkupGridTask.content
    m.top.getScene().OptionSelected="Channels"
    m.top.getScene().callFunc("ShowHomeScreen")

end sub


function GetUrls() as Object
    sec = CreateObject("roRegistrySection", m.global.appName)

    if sec.Exists("URL")
        storedJson = sec.Read("URL")
        if storedJson <> ""
            jsonList = ParseJson(storedJson)
            if Type(jsonList) = "roArray"
              ?"json list"jsonList


                return jsonList ' ✅ Already contains parsed roAssociativeArray items
            end if
        end if
    end if

    return []
end function

 function OnkeyEvent(key as string, press as boolean) as boolean

    result = false

    if press
         if key="left" and (m.playlist.hasFocus() or m.btnHome.hasFocus())
      m.btnPlaylistN.focusfootprintbitmapuri="pkg:/images/btnPlUF.png"
      m.playlist.setFocus(false)
      m.btnHome.setFocus(false)
      m.btnPlaylistN.setFocus(true)
      return true
       else if key="right" and (m.btnHomeN.hasFocus() or m.btnSearchN.hasFocus() or m.btnPlaylistN.hasFocus() or m.btnFavN.hasFocus() or m.btnInputN.hasFocus() or m.btnSettingN.hasFocus())
      m.btnPlaylistN.focusfootprintbitmapuri="pkg:/images/btnPlF.png"
      m.top.setFocus(false)
      if m.noContGroup.visible
        m.btnHome.setFocus(true)
      else
      m.playlist.setFocus(true)
      end if
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