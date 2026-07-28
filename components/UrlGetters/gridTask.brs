sub init()

  m.top.functionName = "buildContent"
 

  
end sub

' sub buildContent()
'     gridContent = CreateObject("roSGNode", "ContentNode")
'     count = 0

'     for each channel in m.top.channels
'         if channel.group = m.top.optionSelected or m.top.optionSelected = "Channels"
'             itemNode = gridContent.createChild("SimpleRowListItemData")
'             itemNode.title = channel.name
'             itemNode.videoTitle = channel.name
'             itemNode.imagePath = channel.logo
'             itemNode.videoPath = channel.url
            
'             itemNode.groupTitle = m.top.optionSelected

'             count = count + 1
'             ' if count >= 300
'             '     exit for
'             ' end if
'         end if
'     end for

'     m.top.content = gridContent
'     ?"content node loaded"m.top.content.getChildCount()
    
' end sub


sub buildContent()
    gridContent = CreateObject("roSGNode", "ContentNode")
    count = 0

    for each channel in m.top.channels
        if m.top.optionSelected = "Channels"
            ' Show items that are neither Movies nor Series
            if channel.group <> "Movies" and channel.group <> "Series"
                itemNode = gridContent.createChild("SimpleRowListItemData")
                itemNode.title = channel.name
                itemNode.videoTitle = channel.name
                itemNode.imagePath = channel.logo
                itemNode.videoPath = channel.url
                itemNode.groupTitle = "Channels"
                count = count + 1
            end if
        else
            ' Show Movies or Series based on the selected category
            if channel.group = m.top.optionSelected
                itemNode = gridContent.createChild("SimpleRowListItemData")
                itemNode.title = channel.name
                itemNode.videoTitle = channel.name
                itemNode.imagePath = channel.logo
                itemNode.videoPath = channel.url
                itemNode.groupTitle = channel.group
                count = count + 1
            end if
        end if
    end for

    m.top.content = gridContent
    ?"content node loaded: "; m.top.content.getChildCount()
end sub
