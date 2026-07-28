sub init()
  m.btnm3u = m.top.findNode("btnm3u")
  m.btnsq = m.top.findNode("btnsq")
  m.inputGroup = m.top.findNode("inputGroup")
  m.inputKeyBoardGroup = m.top.findNode("inputKeyBoardGroup")
  m.btnSubmitKey = m.top.findNode("btnSubmitKey")
  m.checkTimer = m.top.findNode("checkTimer")
  m.checkTimer.ObserveField("fire", "OnTimerFire")
 


  m.btnplaylist = m.top.findNode("btnplaylist")
  m.btnplaylistText = m.top.findNode("btnplaylistText")
  m.btnlink = m.top.findNode("btnlink")
  m.btnlinkText = m.top.findNode("btnlinkText")
  m.btnsubmit = m.top.findNode("btnsubmit")
  m.isLink = false
  m.apiQr = m.top.findNode("apiQr")

  m.inputkeyboard = m.top.findNode("inputkeyboard")
  m.inputkeyboard.domain = "generic"
  m.inputKeyBoardGroup.ObserveField("visible", "onKeyBoardGroupVisible")
  m.btnm3u.ObserveField("buttonSelected", "onbtnm3uSelect")
  m.btnsq.ObserveField("buttonSelected", "onbtnsqSelect")
  m.btnplaylist.ObserveField("buttonSelected", "onbtnplaylistSelect")
  m.btnlink.ObserveField("buttonSelected", "onbtnlinkSelect")
  m.btnsubmit.ObserveField("buttonSelected", "onbtnsubmitSelect")
  m.btnSubmitKey.ObserveField("buttonSelected", "onbtnsubmitKeySelect")

  m.inputkeyboard.ObserveField("text", "onKeyboardText")
  m.btnlinkText.text = "https://iptv-org.github.io/iptv/categories/movies.m3u"
  ' m.inputkeyboard.showTextEditBox=false
  ' m.btnsearch=m.top.findNode("btnsearch")
  ' m.btnsearch.ObserveField("buttonSelected","onbtnsearchSelect")
  'm.btnText.text="https://iptv-org.github.io/iptv/index.m3u"
   m.urlsGroup=m.top.findNode("urlsGroup")
  m.categoryList=m.top.findNode("categoryList")
  m.btnGetUrls=m.top.findNode("btnGetUrls")
  m.btnGetUrls.observeField("buttonSelected","onbtnGetUrlsSelect")
  m.urlsArray = [
    {
      "category": "Auto",
      "url": "https://iptv-org.github.io/iptv/categories/auto.m3u"
    },
    {
      "category": "Business",
      "url": "https://iptv-org.github.io/iptv/categories/business.m3u"
    },
    {
      "category": "Classic",
      "url": "https://iptv-org.github.io/iptv/categories/classic.m3u"
    },
    {
      "category": "Comedy",
      "url": "https://iptv-org.github.io/iptv/categories/comedy.m3u"
    },
    {
      "category": "Documentary",
      "url": "https://iptv-org.github.io/iptv/categories/documentary.m3u"
    },
    {
      "category": "Drama",
      "url": "https://iptv-org.github.io/iptv/categories/drama.m3u"
    },
    {
      "category": "Education",
      "url": "https://iptv-org.github.io/iptv/categories/education.m3u"
    },
    {
      "category": "Entertainment",
      "url": "https://iptv-org.github.io/iptv/categories/entertainment.m3u"
    },
    {
      "category": "Family",
      "url": "https://iptv-org.github.io/iptv/categories/family.m3u"
    },
    {
      "category": "Fashion",
      "url": "https://iptv-org.github.io/iptv/categories/fashion.m3u"
    },
    {
      "category": "Food",
      "url": "https://iptv-org.github.io/iptv/categories/food.m3u"
    },
    {
      "category": "General",
      "url": "https://iptv-org.github.io/iptv/categories/general.m3u"
    },
    {
      "category": "Health",
      "url": "https://iptv-org.github.io/iptv/categories/health.m3u"
    },
    {
      "category": "History",
      "url": "https://iptv-org.github.io/iptv/categories/history.m3u"
    },
    {
      "category": "Hobby",
      "url": "https://iptv-org.github.io/iptv/categories/hobby.m3u"
    },
    {
      "category": "Kids",
      "url": "https://iptv-org.github.io/iptv/categories/kids.m3u"
    },
    {
      "category": "Legislative",
      "url": "https://iptv-org.github.io/iptv/categories/legislative.m3u"
    },
    {
      "category": "Lifestyle",
      "url": "https://iptv-org.github.io/iptv/categories/lifestyle.m3u"
    },
    {
      "category": "Movies",
      "url": "https://iptv-org.github.io/iptv/categories/movies.m3u"
    },
    {
      "category": "Music",
      "url": "https://iptv-org.github.io/iptv/categories/music.m3u"
    },
    {
      "category": "News",
      "url": "https://iptv-org.github.io/iptv/categories/news.m3u"
    },
    {
      "category": "Quiz",
      "url": "https://iptv-org.github.io/iptv/categories/quiz.m3u"
    },
    {
      "category": "Religious",
      "url": "https://iptv-org.github.io/iptv/categories/religious.m3u"
    },
    {
      "category": "Sci-Fi",
      "url": "https://iptv-org.github.io/iptv/categories/sci-fi.m3u"
    },
    {
      "category": "Shop",
      "url": "https://iptv-org.github.io/iptv/categories/shop.m3u"
    },
    {
      "category": "Sports",
      "url": "https://iptv-org.github.io/iptv/categories/sports.m3u"
    },
    {
      "category": "Travel",
      "url": "https://iptv-org.github.io/iptv/categories/travel.m3u"
    },
    {
      "category": "Weather",
      "url": "https://iptv-org.github.io/iptv/categories/weather.m3u"
    },
    {
      "category": "Custom",
      "url": "Custom"
    }
  ]

  content = CreateObject("roSGNode", "ContentNode")

for each item in m.urlsArray
    node = content.CreateChild("ContentNode")
    node.title = item.url
    node.url = item.url
end for

m.categoryList.content = content
m.categoryList.observeField("itemSelected","onCategorySelected")




end sub

sub onCategorySelected(event as Object)
    index = event.getData()
    item = m.urlsArray[index]

     m.urlsGroup.visible=false
    m.categoryList.setfocus(false)
    if item.url<>"Custom"
    m.btnlinkText.text=item.url
    m.btnplaylistText.text=item.category
        m.btnsubmit.setfocus(true)


    else
      m.btnlinkText.text=""
      m.btnplaylistText.text=""
      m.btnplaylist.setfocus(true)
    end if

   
   
end sub

sub onbtnGetUrlsSelect()
  m.urlsGroup.visible=true
  m.categoryList.setfocus(true)

end sub

sub OnTimerFire()
  ?"Timer Fire AccountChecker"
  m.AccountChecker = CreateObject("roSGNode", "UserCheckerTask")
  m.AccountChecker.ObserveField("isError", "fetchData")
  m.AccountChecker.ObserveField("arrayObject", "setUserPlaylist")
  m.AccountChecker.control = "RUN"

end sub

sub fetchData()
  m.checkTimer.control = "start"

end sub

sub onKeyBoardGroupVisible()
  if m.inputKeyBoardGroup.visible
    m.inputGroup.translation = [1106, 204]
    m.btnsubmit.visible = false

  else
    m.inputGroup.translation = [1106, 474]
    m.btnsubmit.visible = true


  end if

end sub

sub onbtnsubmitKeySelect()
  m.btnSubmitKey.setFocus(false)
  m.inputkeyboardGroup.visible = false
  if m.isLink
    m.btnlink.setFocus(true)
  else
    m.btnplaylist.setFocus(true)

  end if


end sub



sub onbtnsubmitSelect()
  if IsValidM3ULink(m.btnlinkText.text) and m.btnplaylistText.text <> ""
    m.global.m3uLink = m.btnlinkText.text
    playListObj = { "PlayListName": m.btnplaylistText.text,
      "url": m.btnlinkText.text

    }
    AddToURLs(playListObj)
    m.top.getScene().callFunc("CallMenuScreen")
  else
    m.dialog = CreateObject("roSGNode", "Dialog")
    m.dialog.title = "Invalid URL"
    m.dialog.message = "Please Enter A Valid URL "
    m.dialog.ObserveField("buttonSelected", "onDoneSelected")

    m.top.getScene().dialog = m.dialog
  end if

end sub

sub setUserPlaylist()
  currContent = m.AccountChecker.arrayObject
  urlArray = currContent.playlist_urls

  if urlArray <> invalid
    currUrl = urlArray[0]

  end if
  if IsValidM3ULink(currUrl) and currUrl <> ""
    m.global.m3uLink = currUrl
    playListObj = { "PlayListName": "QR Added Link " + GetCurrentTimeHHMMSS(),
      "url": currUrl

    }
    AddToURLs(playListObj)
    m.top.getScene().callFunc("CallMenuScreen")
  else
    m.dialog = CreateObject("roSGNode", "Dialog")
    m.dialog.title = "Invalid URL"
    m.dialog.message = "Please Enter A Valid URL "
    m.dialog.ObserveField("buttonSelected", "onDoneSelected")

    m.top.getScene().dialog = m.dialog
  end if

end sub

sub onbtnm3uSelect()
  m.inputGroup.visible = true
  m.apiQr.visible = false
  m.btnplaylist.setfocus(true)



end sub
sub onbtnsqSelect()
  m.inputGroup.visible = false
   m.apiQr.visible = true
   m.apiQr.text ="https://api.fbaseller.pro/generate-qr/"+(m.top.getScene().Mac).ToStr()
  ?"api url"m.apiQr.uri
  ' m.apiQr.visible = true

  m.AccountChecker = CreateObject("roSGNode", "UserCheckerTask")
  m.AccountChecker.ObserveField("isError", "fetchData")
  m.AccountChecker.ObserveField("arrayObject", "setUserPlaylist")
  m.AccountChecker.control = "RUN"



end sub
sub onbtnlinkSelect()
  m.isLink = true
  if m.btnlinkText.text = "M3U Link"
    m.inputkeyboard.textEditBox.text = ""
  else
    m.inputkeyboard.textEditBox.text = m.btnlinkText.text
  end if
  m.inputKeyBoardGroup.visible = true
  m.inputkeyboard.setfocus(true)




end sub
sub onbtnplaylistSelect()
  m.isLink = false
  if m.btnplaylistText.text = "Playlist Name"
    m.inputkeyboard.textEditBox.text = ""
  else
    m.inputkeyboard.textEditBox.text = m.btnplaylistText.text
  end if

  m.inputKeyBoardGroup.visible = true
  m.inputkeyboard.setfocus(true)




end sub

sub onKeyboardText()
  ' m.btnText.text="https://iptv-org.github.io/iptv/"+m.inputkeyboard.text
  if m.isLink
    m.btnlinkText.text = m.inputkeyboard.text
  else
    m.btnplaylistText.text = m.inputkeyboard.text


  end if


end sub

function OnkeyEvent(key as string, press as boolean) as boolean

  result = false

  if press
    ' if key="down" and m.inputkeyboard.visible
    '   m.inputkeyboard.setfocus(false)
    '   ' m.btnsearch.setfocus(true)

    '   return true
    ' else if key="up" and m.btnsearch.hasfocus()
    ' m.btnsearch.setfocus(false)
    ' m.inputkeyboard.setfocus(true)
    ' return true
    if key = "down" and m.inputKeyBoardGroup.visible
      m.inputkeyboard.setfocus(false)
      ' m.inputkeyboard.visible=false
      m.btnSubmitKey.setfocus(true)

      return true

    else if key = "up" and m.btnSubmitKey.hasFocus()
      m.inputkeyboard.setfocus(true)
      m.btnSubmitKey.setfocus(false)

      return true
    else if key = "up" and m.btnsq.hasFocus()
      m.btnsq.setfocus(false)
      m.btnm3u.setfocus(true)

      return true
       else if key = "up" and m.btnGetUrls.hasFocus()
      m.btnGetUrls.setfocus(false)
      m.btnlink.setfocus(true)

      return true
    else if key = "up" and m.btnsubmit.hasFocus()
      m.btnsubmit.setfocus(false)
      m.btnGetUrls.setfocus(true)

      return true
    else if key = "up" and m.btnlink.hasFocus()
      m.btnlink.setfocus(false)
      m.btnplaylist.setfocus(true)

      return true
    else if key = "down" and m.btnm3u.hasFocus()
      m.btnm3u.setfocus(false)
      m.btnsq.setfocus(true)

      return true

       else if key = "down" and m.btnlink.hasFocus()
      m.btnlink.setfocus(false)
      m.btnGetUrls.setfocus(true)

      return true
    else if key = "down" and m.btnplaylist.hasFocus()
      m.btnplaylist.setfocus(false)
      m.btnlink.setfocus(true)

      return true
    else if key = "down" and m.btnGetUrls.hasFocus()
      m.btnGetUrls.setfocus(false)
      m.btnsubmit.setfocus(true)

      return true
    else if key = "right" and (m.btnsq.hasFocus() or m.btnm3u.hasFocus() )  and m.inputGroup.visible
      m.btnm3u.setfocus(false)
      m.btnsq.setfocus(false)
      m.btnplaylist.setfocus(true)
      return true
    else if key = "left" and (m.btnlink.hasFocus() or m.btnplaylist.hasFocus() or m.btnsubmit.hasFocus() or m.btnGetUrls.hasFocus()) and m.inputGroup.visible
      m.btnlink.setfocus(false)
      m.btnsubmit.setfocus(false)
      m.btnplaylist.setfocus(false)
      m.btnm3u.setfocus(true)

      return true
      else if key="back" and m.urlsGroup.visible
        m.urlsGroup.visible=false
        m.categoryList.setfocus(false)
        m.btnGetUrls.setfocus(true)
        return true
      else if key="back" and m.inputKeyBoardGroup.visible
        onbtnsubmitKeySelect()
        return true

    end if
    return result


  end if

end function

function IsValidM3ULink(url as string) as boolean
  if url = invalid or url = "" then return false

  ' Check if URL starts with http/https and ends with .m3u or .m3u8
  lowerUrl = LCase(url)
  if (Left(lowerUrl, 7) = "http://" or Left(lowerUrl, 8) = "https://") and (Right(lowerUrl, 4) = ".m3u" or Right(lowerUrl, 5) = ".m3u8")
    return true
  end if

  return false
end function

sub AddToURLs(itemContent as object)
  sec = CreateObject("roRegistrySection", m.global.appName)

  ' Create a JSON-safe object (copy only primitives)
  jsonItem = {
    name: itemContent.playListName,
    url: itemContent.url
  }
  sec.Write("currentURL", itemContent.url)

  ' Read existing list
  entries = []
  if sec.Exists("URL")
    storedJson = sec.Read("URL")
    if storedJson <> ""
      entries = ParseJson(storedJson)
    end if
  end if

  ' Remove any existing entry with the same URL
  cleanedEntries = []
  for each entry in entries
    if entry.url <> jsonItem.url
      cleanedEntries.Push(entry)
    end if
  end for

  ' Add the new entry
  cleanedEntries.Push(jsonItem)

  ' Optional: Print entries for debugging
  for each item in cleanedEntries
    ?"entries value", item
  end for

  ' Save back to registry
  sec.Write("URL", FormatJson(cleanedEntries))
  sec.Flush()
end sub

function GetRecentItems() as object
  sec = CreateObject("roRegistrySection", m.global.appName)

  if sec.Exists("URL")
    storedJson = sec.Read("URL")
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

function GetCurrentTimeHHMMSS() as string
  dt = CreateObject("roDateTime")

  hour = dt.GetHours()
  minute = dt.GetMinutes()
  second = dt.GetSeconds()



  return PadTwoDigits(hour) + PadTwoDigits(minute) + PadTwoDigits(second)
end function

function PadTwoDigits(n as integer) as string
  if n < 10
    return "0" + Str(n)
  else
    return Str(n)
  end if
end function