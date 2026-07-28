sub init()
     m.navBar=m.top.findNode("navBar")
   navBarInit("Setting")
    m.top.observeField("visible","onVisibleChange")
    m.btnRateUs=m.top.findNode("btnRateUs")
    m.btnShare=m.top.findNode("btnShare")
    m.btnContact=m.top.findNode("btnContact")
    m.QRPoster=m.top.findNode("QRPoster")
    m.btnRateUs.observeField("buttonSelected","onbtnRateSelected")
    m.btnContact.observeField("buttonSelected","onbtnContactSelected")
    m.btnShare.observeField("buttonSelected","onbtnShareSelected")


end sub

sub onbtnRateSelected()
 m.QRPoster.uri="pkg:/images/ruQR.png"


end sub

sub onbtnContactSelected()
           m.QRPoster.uri="pkg:/images/cuQR.png"


end sub

sub onbtnShareSelected()
           m.QRPoster.uri="pkg:/images/saQR.png"


end sub

sub onVisibleChange()
  if m.top.visible
    navBarInit("Setting")
    m.QRPoster.uri="pkg:/images/ruQR.png"
    m.btnRateUs.setFocus(true)
    
  end if

 end sub


function OnkeyEvent(key as string, press as boolean) as boolean

    result = false

    if press
         if key="left" and (m.btnRateUs.hasFocus() or m.btnContact.hasFocus() or m.btnShare.hasFocus())
      m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetUF.png"
      m.btnRateUs.setFocus(false)
      m.btnContact.setFocus(false)
      m.btnShare.setFocus(false)
      m.btnSettingN.setFocus(true)
      return true
       else if key="right" and (m.btnHomeN.hasFocus() or m.btnSearchN.hasFocus() or m.btnPlaylistN.hasFocus() or m.btnFavN.hasFocus() or m.btnInputN.hasFocus() or m.btnSettingN.hasFocus())
      m.btnSettingN.focusfootprintbitmapuri="pkg:/images/btnSetF.png"
      m.top.setFocus(false)
      
       m.QRPoster.uri="pkg:/images/raQR.png"
      m.btnRateUs.setFocus(true)
      
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
      else if key="down" and m.btnRateUs.hasFocus()
        m.btnRateUs.setFocus(false)
      m.btnContact.setFocus(true)
      return true

       else if key="down" and m.btnContact.hasFocus()
        m.btnContact.setFocus(false)
      m.btnShare.setFocus(true)
      return true

       else if key="up" and m.btnShare.hasFocus()
        m.btnShare.setFocus(false)
      m.btnContact.setFocus(true)
      return true

       else if key="up" and m.btnContact.hasFocus()
        m.btnContact.setFocus(false)
      m.btnRateUs.setFocus(true)
      return true

        end if


    end if
    end function