sub init()
   m.itemName=m.top.findNode("itemName")
   m.itemImage=m.top.findNode("itemImage")
   m.itemBG=m.top.findNode("itemBG")
end sub

sub itemContentChanged()
    m.itemContent=m.top.itemContent
   ' ?"Item Component"m.itemContent
   m.itemName.text=m.itemContent.videoTitle
   m.itemImage.uri=m.itemContent.imagePath
  
   


end sub

sub showfocus()
    if m.top.focusPercent > 0.5 'and m.top.itemHasFocus
        m.itemBG.uri="pkg:/images/ThF.png"
        ' m.itemName.color="#131314"
    else
        m.itemBG.uri="pkg:/images/"
        ' m.itemName.color="#ffffff"
      end if

end sub

sub showrowfocus()
    if m.top.gridHasFocus or m.top.rowHasFocus
        ?"564"
       m.itemBG.visible=true

    else
        ?"563"
       m.itemBG.visible=false


    end if
    ' showfocus()

end sub