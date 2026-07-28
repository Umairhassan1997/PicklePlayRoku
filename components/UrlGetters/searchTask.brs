sub init()

  m.top.functionName = "buildContent"
 

  
end sub

sub buildContent()
    gridContent = CreateObject("roSGNode", "ContentNode")
    

    for each channel in m.top.channels
        if Instr(1, LCase(channel.name), LCase(m.top.inputString)) > 0
            itemNode = gridContent.createChild("SimpleRowListItemData")
            itemNode.title = channel.name
            itemNode.videoTitle = channel.name
            itemNode.imagePath = channel.logo
            itemNode.videoPath = channel.url
            
            itemNode.groupTitle = channel.group

        end if
    end for

    m.top.content = gridContent
    ?"content node loaded"m.top.content.getChildCount()
    
end sub
