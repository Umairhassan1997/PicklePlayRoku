sub init()
   m.scene=m.top.getScene()
    m.top.observeField("visible","onVisibleChange")
    m.btnMonthly=m.top.findNode("btnMonthly")
    m.btnYearly=m.top.findNode("btnYearly")
    m.btnSubscribe=m.top.findNode("btnSub")
    m.btnMonthly.observeField("buttonSelected","onbtnMonthlySelected")
    m.btnYearly.observeField("buttonSelected","onbtnYearlySelected")
    ' m.btnSubmit.observeField("buttonSelected","onbtnSubmitSelected")
end sub

sub onVisibleChange()
  if m.top.visible
    m.btnMonthly.setFocus(true)
    
  end if

 end sub

sub onbtnMonthlySelected()
  m.scene.isSubYearly=false
    m.btnMonthly.focusfootprintbitmapuri="pkg:/images/MUF.png"
    m.btnYearly.focusfootprintbitmapuri="pkg:/images/YUUF.png"
    m.btnMonthly.setFocus(false)
    m.btnSubscribe.setFocus(true)


end sub


sub onbtnYearlySelected()
  m.scene.isSubYearly=true
     m.btnMonthly.focusfootprintbitmapuri="pkg:/images/MUUF.png"
    m.btnYearly.focusfootprintbitmapuri="pkg:/images/YUF.png"
     m.btnYearly.setFocus(false)
    m.btnSubscribe.setFocus(true)


end sub


function OnkeyEvent(key as string, press as boolean) as boolean

    if press
      if key="right" and m.btnMonthly.hasFocus()
        m.btnMonthly.setFocus(false)
      m.btnYearly.setFocus(true)
      return true
       else if key="left" and m.btnYearly.hasFocus()
        m.btnYearly.setFocus(false)
      m.btnMonthly.setFocus(true)
      return true
       else if key="up" and m.btnSubscribe.hasFocus()
 m.btnMonthly.focusfootprintbitmapuri="pkg:/images/MUUF.png"
    m.btnYearly.focusfootprintbitmapuri="pkg:/images/YUUF.png"
    m.btnMonthly.setFocus(true)
    return true


        end if


    end if
    return false
end function



