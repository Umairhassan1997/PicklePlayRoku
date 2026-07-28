 sub init()
   m.row_List = m.top.findNode("row_List")
   m.navBar=m.top.findNode("navBar")

   m.noContGroup=m.top.findNode("noContGroup")
     m.btnHome=m.top.findNode("btnHome")
   navBarInit("Home2")
   VerifySubscription()
   m.closeDialogTimer=m.top.findNode("closeDialogTimer")
   m.closeDialogTimer.observeField("fire","onCloseDialogTimerFire")
   m.scene=m.top.getScene()
   m.busyspinner = m.top.findNode("menuSpinner")
   m.busyspinner.poster.observeField("loadStatus", "showspinner")
   m.busyspinner.poster.uri = "pkg:/images/loader.png"
   m.top.observeField("visible","onVisibleChange")
   screenWidth = 1920
    screenHeight = 1080

    posterWidth = m.busyspinner.poster.width
    posterHeight = m.busyspinner.poster.height

    ' Calculate center position
    x = (screenWidth - posterWidth) / 2
    y = (screenHeight - posterHeight) / 2

    m.busyspinner.poster.translation = [x, y]
  
   
   


  
  gridContent = CreateObject("roSGNode", "ContentNode")

' for each dummyValue in dummyPacks
'     for each category in dummyValue
'         items = dummyValue[category] ' example: category = "Cat1", items = [{"title":"ABC"}, {"title":"XYZ"}]

'         for each data in items
'             itemNode = gridContent.createChild("SimpleRowListItemData")
'             itemNode.title = data.name
'             itemNode.videoTitle = data.name
'             itemNode.imagePath = data.logo
'             itemNode.videoPath = data.url
'         end for

'     end for
' end for
' m.readMarkupGridTask = createObject("roSGNode", "appSettingsData")
' m.readMarkupGridTask.observeField("content", "onContent")
' m.readMarkupGridTask.control = "RUN"
' count=0
'     for each channel in m.global.ChannelsArray
'         ?"channel"channel
'         if channel.group = m.scene.OptionSelected or m.scene.OptionSelected="Channels"
'             itemNode = gridContent.createChild("SimpleRowListItemData")
'             itemNode.title = channel.name
'             itemNode.videoTitle = channel.name
'             itemNode.imagePath = channel.logo
'             itemNode.videoPath = channel.url
'             itemNode.groupTitle = channel.group
'              count = count + 1
'             if count >= 300
'                 exit for
'             end if

'         end if
'     end for
m.contentBuilderTask=CreateObject("roSGNode","gridTask")
if m.global.playlistArray<>invalid
  m.contentBuilderTask.channels = m.global.playlistArray

else
m.contentBuilderTask.channels = m.global.ChannelsArray
end if
m.contentBuilderTask.optionSelected = m.scene.OptionSelected
m.contentBuilderTask.control = "run"
m.top.findNode("screenNameLabel").text=m.scene.OptionSelected
' Observe completion
m.contentBuilderTask.ObserveField("content", "onContent")

           
  

     m.row_List.setFocus(true)
     m.row_List.observefield("ItemSelected","onrowitemselected")
          m.row_List.observefield("ItemFocused","onrowitemfocused")

     m.video = m.top.findNode("videoPlayer")

'     ?"value count"m.pack_List.content.getChild(0).getChildCOunt()
' m.video = m.top.findNode("videoPlayer")
'     m.video.visible=true

'     m.videoPlayer2 = CreateObject("roSGNode", "ContentNode")
'     m.videoPlayer2.url = "https://live-hls-web-aje.getaj.net/AJE/index.m3u8"
'     m.videoPlayer2.streamformat = "hls"
'     m.videoPlayer2.title="Sample Video"

'     m.video.content = m.videoPlayer2
'     m.video.control = "play"
 
 end sub

 sub onCloseDialogTimerFire()
  m.Notifier.close=true


 end sub

 sub onContent()
    m.busyspinner.visible=false
  m.row_List.content = m.contentBuilderTask.content
  ?"child count"m.row_List.content.getchildCount()
  if m.row_List.content.getchildCount()=0
       m.row_List.visible=false
      m.row_List.setFocus(false)
      m.noContGroup.visible=true
      m.btnHome.setFocus(true)
  else
    if m.global.isFirstUse
       m.Notifier = createObject("roSGNode", "StandardMessageDialog")
      m.Notifier.title = "Add to Favorites"
      m.Notifier.message = ["Press * to Add this Channel to Favorites."]
      m.top.getScene().dialog=m.Notifier
      m.closeDialogTimer.control="start"
      m.global.isFirstUse=false
  

     end if

     if m.global.playlistArray<>invalid
      m.global.playlistArray=invalid

     end if



  end if
  

 end sub


 sub onrowitemfocused(evt)
  data=evt.getdata()
    row=data
    m.rowdatafocused=m.row_List.content.getchild(row)

 end sub



 sub onrowitemselected(evt)
    data=evt.getdata()
    row=data
    ' col=data[1]
    m.rowdata=m.row_List.content.getchild(row)'.getchild(col)

    AddToRecents(m.rowdata)

    ' GetRecentItems()
    ' if m.top.isSubscribed
    m.video.visible=true

    m.videoPlayer2 = CreateObject("roSGNode", "ContentNode")
    m.videoPlayer2.url = m.rowdata.videoPath
    m.videoPlayer2.streamformat = "hls"
    m.videoPlayer2.title=m.rowdata.title

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

 sub onEmptyDialogSelected()

  if m.EmptyDialog.buttonSelected=0
    m.EmptyDialog.close=true

  end if


 end sub

 sub onVisibleChange()
  if m.top.visible
    ?"visible true"
    navBarInit("Home")
    if m.row_List.content.getchildCount()=0
      m.btnHome.setFocus(true)
    else
    m.row_List.setFocus(true)
    end if
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
      if m.noContGroup.visible
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
       else if key="options" and m.row_List.hasFocus()
        ?"Added to fav"
        AddToFavs(m.rowdatafocused)
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



sub AddToRecents(itemContent as Object)
    sec = CreateObject("roRegistrySection",  "RecentReg")

    ' Create a JSON-safe object (copy only primitives)
    jsonItem = {
        name: itemContent.title,
        url: itemContent.videoPath,
        logo: itemContent.imagePath,
        group: itemContent.groupTitle
    }

    ' Read existing list
    entries = []
    if sec.Exists("entries")
        storedJson = sec.Read("entries")
        if storedJson <> ""
            entries = ParseJson(storedJson)
        end if
    end if

    ' Check for duplicates based on name
    for each entry in entries
        if entry.name = jsonItem.name
            ' Duplicate found, do not add
            return
        end if
    end for

    ' Add new item
    entries.Push(jsonItem)

    ' Write back to registry
    sec.Write("entries", FormatJson(entries))
    sec.Flush()
end sub


sub AddToFavs(itemContent as Object)
    sec = CreateObject("roRegistrySection",  "FavReg")

    ' Create a JSON-safe object (copy only primitives)
    jsonItem = {
        name: itemContent.title,
        url: itemContent.videoPath,
        logo: itemContent.imagePath,
        group: itemContent.groupTitle
    }

    ' Read existing list
    entries = []
    if sec.Exists("entries")
        storedJson = sec.Read("entries")
        if storedJson <> ""
            entries = ParseJson(storedJson)
        end if
    end if

    ' Check for duplicates based on name
    for each entry in entries
        if entry.name = jsonItem.name
            ' Duplicate found, do not add
            return
        end if
    end for

    ' Add new item
    entries.Push(jsonItem)

    ' Write back to registry
    sec.Write("entries", FormatJson(entries))
    sec.Flush()
end sub

