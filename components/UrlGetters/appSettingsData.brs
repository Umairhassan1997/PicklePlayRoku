sub init()

  m.top.functionName = "getcontent"
 

  
end sub

sub getcontent()

  m3uList = []
  xfer = CreateObject("roURLTransfer")
  xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
  xfer.SetURL(m.top.inputUrl)
  ' xfer.SetURL("https://devtest-storage.b-cdn.net/Roku/KT/Jsons/as.json")
  rsp = xfer.GetToString()
  lines = rsp.tokenize(chr(10)) ' split by newline
  ?"lines"lines
  channel = {}

  for i = 0 to lines.count() - 1
      line = lines[i].trim()
      if line.left(7) = "#EXTINF"
          channel = parseExtInfLine(line)
      elseif line.left(1) <> "#" 'and channel <> {}
          channel.url = line
          m3uList.push(channel)
          channel = {}
      end if
  end for
   
 items=[]
 gridContent = CreateObject("roSGNode", "ContentNode")
count=0
  ' for each channel in m3uList
  '   ?"channel"channel
  '                 itemNode = gridContent.createChild("SimpleRowListItemData")
  '                 itemNode.title = channel.name
  '                 itemNode.videoTitle = channel.name
  '                 itemNode.imagePath = channel.logo
  '                 itemNode.videoPath = channel.url
  '                 itemNode.groupTitle=channel.group
  '                 count = count + 1
  '               if count >= 300
  '                   exit for
  '               end if
  '             end for
m.top.content = m3uList




  
end sub

' function parseExtInfLine(line as string) as object
'   channel = {}

'   ' Create regex with 3 args as required
'   regex = CreateObject("roRegex", "tvg-logo=""([^""]+)""", "i")
'   matches = regex.Match(line)

'   if matches.count() > 1 then
'       channel.logo = matches[1]
'   else
'       channel.logo = ""
'   end if

'   ' Extract channel name (after comma)
'   commaPos = line.instr(",")
'   if commaPos > -1 then
'       channel.name = line.mid(commaPos + 1).trim()
'   else
'       channel.name = "Unknown"
'   end if

'   return channel
' end function
function parseExtInfLine(line as string) as object
    channel = {}

    ' Extract tvg-logo
    logoRegex = CreateObject("roRegex", "tvg-logo=""([^""]+)""", "i")
    logoMatches = logoRegex.Match(line)
    if logoMatches.count() > 1 then
        channel.logo = logoMatches[1]
    else
        channel.logo = ""
    end if

    ' Extract group-title
    groupRegex = CreateObject("roRegex", "group-title=""([^""]+)""", "i")
    groupMatches = groupRegex.Match(line)
    if groupMatches.count() > 1 then
        channel.group = groupMatches[1]
    else
        channel.group = ""
    end if

    ' Extract channel name (after comma)
    commaPos = line.instr(",")
    if commaPos > -1 then
        channel.name = line.mid(commaPos + 1).trim()
    else
        channel.name = "Unknown"
    end if

    return channel
end function
