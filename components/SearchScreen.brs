sub init()  
  m.noContGroup=m.top.findNode("noContGroup")
     m.btnHome=m.top.findNode("btnHome")
    m.navBar=m.top.findNode("navBar")
    m.btnSubmit=m.top.findNode("btnSubmit")
    m.btnSubmit.observeField("buttonSelected","onbtnNameSelected")
   navBarInit("Search")
   m.top.observeField("visible","onVisibleChange")
   
    m.inputGroup=m.top.findNode("inputGroup")
    m.ResultsGroup=m.top.findNode("ResultsGroup")
    m.btnName=m.top.findNode("btnName")
    m.labelName=m.top.findNode("labelName")
    m.btnName.ObserveField("buttonSelected","onbtnNameSelected")
    m.inputkeyboard=m.top.findNode("inputkeyboard")
    m.inputkeyboard.domain = "generic"
      m.inputkeyboard.ObserveField("text","onKeyboardText")
      m.inputkeyboard.setFocus(true)
      m.searchChannelGrid=m.top.findNode("searchChannelGrid")
      m.searchChannelGrid.ObserveField("itemSelected","onGridItemSelected")
    m.video = m.top.findNode("videoPlayer")

      
end sub
sub onVisibleChange()
  if m.top.visible
    navBarInit("Search")
    if m.inputGroup.visible
      m.inputkeyboard.setFocus(true)
    else
    if m.searchChannelGrid.content.getchildCount()=0
      m.btnHome.setFocus(true)
    else
    m.searchChannelGrid.setFocus(true)
    end if

  end if
  end if

 end sub

sub onGridItemSelected(evt)
    index=evt.getData()
   currentIndex= m.searchChannelGrid.content.getChild(index)
   m.videoPlayer2 = CreateObject("roSGNode", "ContentNode")
    m.videoPlayer2.url = currentIndex.videoPath
    m.videoPlayer2.streamformat = "hls"
    m.videoPlayer2.title=currentIndex.title

    m.video.content = m.videoPlayer2
    m.video.visible=true
    m.video.control = "play"
    m.video.setFocus(true)
    m.navBar.visible=false



end sub



 sub onKeyboardText()
  ' m.btnText.text="https://iptv-org.github.io/iptv/"+m.inputkeyboard.text
   m.labelName.text=m.inputkeyboard.text


 end sub

sub onbtnNameSelected()
    if m.labelName.text<>"Search by name" 
        m.inputGroup.visible=false
        m.ResultsGroup.visible=true
        m.contentBuilderTask=CreateObject("roSGNode","searchTask")
      m.contentBuilderTask.channels = m.global.ChannelsArray
     m.contentBuilderTask.inputString = m.labelName.text
     m.contentBuilderTask.ObserveField("content","onChannelsLoaded")
     m.contentBuilderTask.control = "run"
        

    end if


end sub

sub onChannelsLoaded()
    m.searchChannelGrid.content=m.contentBuilderTask.content
    m.searchChannelGrid.setFocus(true)
    if m.searchChannelGrid.content.getChildCount()=0
      m.searchChannelGrid.visible=false
      m.searchChannelGrid.setFocus(false)
      m.noContGroup.visible=true
      m.btnHome.setFocus(true)

    end if


end sub

function OnKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press
        if key="back" and m.video.visible and m.ResultsGroup.visible
            m.navBar.visible=true
        m.video.visible=false
        m.video.control="stop"
        m.searchChannelGrid.setFocus(true)
        result=true

        

        else if key="back" and m.ResultsGroup.visible and m.video.visible=false
        m.ResultsGroup.visible=false
        m.searchChannelGrid.visible=true
        m.noContGroup.visible=false
        m.inputGroup.visible=true
        m.inputkeyboard.setFocus(true)
        result=true
     else if key="down" and m.inputGroup.visible and not m.btnSubmit.hasFocus() and not m.btnSearchN.hasFocus() and not m.btnHomeN.hasFocus() and not m.btnPlaylistN.hasFocus() and not m.btnFavN.hasFocus() and not m.btnInputN.hasFocus() and not m.btnSettingN.hasFocus()
       m.inputkeyboard.setFocus(false)
       m.btnSubmit.setFocus(true)
       result=true
        else if key="up" and m.inputGroup.visible and m.btnSubmit.hasFocus()
            m.btnSubmit.setFocus(false)
            m.inputkeyboard.setFocus(true)
            return true
    else if key="left" and (m.btnName.hasFocus() or m.inputkeyboard.visible  or m.searchChannelGrid.hasFocus() or m.btnHome.hasFocus())
      m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaUF.png"
      m.btnName.setFocus(false)
      m.btnHome.setFocus(false)
      m.searchChannelGrid.setFocus(false)
      m.btnSearchN.setFocus(true)
      return true
       else if key="right" and (m.btnHomeN.hasFocus() or m.btnSearchN.hasFocus() or m.btnPlaylistN.hasFocus() or m.btnFavN.hasFocus() or m.btnInputN.hasFocus() or m.btnSettingN.hasFocus())
      m.btnSearchN.focusfootprintbitmapuri="pkg:/images/btnSeaF.png"
      m.top.setFocus(false)
      if m.inputGroup.visible
        m.inputkeyboard.setFocus(true)
      else
        if m.noContGroup.visible
          m.btnHome.setFocus(true)
        else
        m.searchChannelGrid.setFocus(true)
        end if
      end if
    '   m.btnChannels.setFocus(true)
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

     return result

    end if

    end function