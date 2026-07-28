 sub init()
     m.navBar=m.top.findNode("navBar")
   navBarInit("Home2")
   m.row_List = m.top.findNode("row_List")
     m.top.observeField("visible","onVisibleChange")

   VerifySubscription()
    m.noHistGroup=m.top.findNode("noHistGroup")
     m.btnHome=m.top.findNode("btnHome")
          m.focusTimer=m.top.findNode("focusTimer")
          m.focusTimer.observeField("fire","SetFocusonMessage")

    


  
  gridContent = CreateObject("roSGNode", "ContentNode")

    dummyValue=GetRecentItems()
    ?"Favoirtes Count"dummyValue



groupedItems = {}

for each data in dummyValue
    group = data.group ' Assuming "group" is the attribute used to categorize items
    ?"Group name"group
    ' If the group doesn't exist yet, create a new entry for it
    if groupedItems[group] = invalid
        groupedItems[group] = [] ' Initialize an empty array for this group
    end if
    
    ' Add the current item to the appropriate group
    groupedItems[group].Push(data)
end for

' Now, create a ContentNode for each group
for each groupName in groupedItems
    ? "Group: "; groupName ' Debug: Print group name

    ' Create the ContentNode for the group
    groupNode = CreateObject("RoSGNode", "ContentNode") ' ContentNode for the group
    groupNode.title=groupName

    ' Create a RowList for each group to hold the items

    ' Create individual RowListItemData for each item in the group
    for each data in groupedItems[groupName]
        itemNode = groupNode.createChild("SimpleRowListItemData")
        itemNode.title = data.name
        itemNode.videoTitle = data.name
        itemNode.imagePath = data.logo
        itemNode.videoPath = data.url
    end for

    ' Add the RowList to the ContentNode (this is the visual part of the group)

    ' Add the groupNode to gridContent
    gridContent.appendChild(groupNode)
end for


  m.row_List.setFocus(true)
  m.row_List.observeField("content", "onContent")

  m.row_List.content = gridContent
  m.row_List.observefield("rowItemSelected", "onrowitemselected")
  m.video = m.top.findNode("videoPlayer")

      

 
 end sub

 sub onVisibleChange()
  if m.top.visible
  if m.noHistGroup.visible
    m.btnHome.setFocus(true)

  else
    m.row_List.setFocus(true)

  end if
  navBarInit("Home")

end if


 end sub

 sub onContent()
  ' m.row_List.content = m.readMarkupGridTask.content
  ?"child count"m.row_List.content.GetChildCount()
  if m.row_List.content.GetChildCount()=0
    m.focusTimer.control="start"
    
      else
         m.row_List.setFocus(true)

    end if


 end sub

 sub SetFocusonMessage()
   m.row_List.setFocus(false)
    m.btnHomeN.setFocus(false)
      m.row_List.visible=false
      m.noHistGroup.visible=true
      m.btnHome.setFocus(true)
 


 end sub

 sub onrowitemselected(evt)
    data=evt.getdata()
    row=data[0]
     col=data[1]
    rowdata=m.row_List.content.getchild(row).getchild(col)

    ' if m.top.isSubscribed
    m.video.visible=true

    m.videoPlayer2 = CreateObject("roSGNode", "ContentNode")
    m.videoPlayer2.url = rowdata.videoPath
    m.videoPlayer2.streamformat = "hls"
    m.videoPlayer2.title=rowdata.title

    m.video.content = m.videoPlayer2
    m.video.control = "play"
    m.video.setFocus(true)

    ' else

    '   m.subscriptionDialog = createObject("roSGNode", "StandardMessageDialog")
    '   m.subscriptionDialog.title = "Subscribe Now to Watch"
    '   m.subscriptionDialog.message = ["You need subscription to Continue Watching these channels."]
    '   m.subscriptionDialog.buttons = ["OK"]
  
    '   ' observe the dialog's buttonSelected field to handle button selections
    '   m.subscriptionDialog.observeFieldScoped("buttonSelected", "onSubscriptionDialogSelected")
  
    '   ' display the dialog
    '   scene = m.top
    '   scene.dialog = m.subscriptionDialog
    ' end if
 


 end sub


 sub onSubscriptionDialogSelected()

  if m.subscriptionDialog.buttonSelected=0
    m.subscriptionDialog.close=true

  end if


 end sub





function OnKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press
     if key="back" and m.video.visible
        m.video.visible=false
        m.video.control="stop"
        m.row_List.setFocus(true)
        result=true
             else if key="left" and (m.row_List.hasFocus() or m.btnHome.hasFocus())
      m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoUF.png"
      m.row_List.setFocus(false)
      m.btnHome.setFocus(false)
      m.btnHomeN.setFocus(true)
      return true
       else if key="right" and (m.btnHomeN.hasFocus() or m.btnSearchN.hasFocus() or m.btnPlaylistN.hasFocus() or m.btnFavN.hasFocus() or m.btnInputN.hasFocus() or m.btnSettingN.hasFocus())
      ' m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHoF.png"
      m.top.setFocus(false)
      if m.noHistGroup.visible
        m.btnHome.setFocus(true)
      else
      m.row_List.setFocus(true)
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

     return result

    end if

    end function

    
function GetRecentItems() as Object
    sec = CreateObject("roRegistrySection", "RecentReg")

    if sec.Exists("entries")
        storedJson = sec.Read("entries")
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



