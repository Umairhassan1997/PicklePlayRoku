sub init()
   m.itemName=m.top.findNode("itemName")
   m.itemImage=m.top.findNode("itemImage")
end sub

sub itemContentChanged()
    m.itemContent=m.top.itemContent
   ' ?"Item Component"m.itemContent
   m.itemName.text=m.itemContent.videoTitle
   m.itemImage.uri=m.itemContent.imagePath
  
   


end sub

sub showfocus()
    if m.top.focusPercent > 0.5 and m.top.gridHasFocus
        m.itemImage.uri="pkg:/images/temF.png"
        m.itemName.color="#000000"
    else
        m.itemImage.uri="pkg:/images/temUF.png"
       m.itemName.color="#FFFFFF"
      end if

end sub

sub showrowfocus()
    if m.top.gridHasFocus 
        m.itemImage.visible=true
    else
        m.itemName.color="#FFFFFF"
        m.itemImage.visible=false

    end if
     showfocus()

end sub