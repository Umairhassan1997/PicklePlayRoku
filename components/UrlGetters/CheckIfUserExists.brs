sub init()

    m.top.functionName = "fetchData"
end sub



' function fetchData() as void
'     xfer = CreateObject("roURLTransfer")
'     xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
'     xfer.SetURL("http://147.93.86.165:8000/check-status/"+m.top.getScene().Mac)
'     '  xfer.SetURL("http://192.168.0.121:3000/gettoken?info="+m.top.params)

    
'     rsp = xfer.GetToString()
'      rows = {}
     
'     json = ParseJson(rsp)
'     ?"json returned from qr task"json
   
    
'     'parentNode = CreateObject("roSGNode", "ContentNode")
'     if json <> invalid
'         ?"Response from User Task "json
'         if json.has_playlist=invalid or json.has_playlist=false

'            ' fetchData()
'            m.top.isError=true

'         else
'             m.top.arrayObject=json
           

'         end if
'     end if

' end function




function fetchData() as void
    xfer = CreateObject("roURLTransfer")
    xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    xfer.SetURL("https://api.fbaseller.pro/check-status/" + m.top.getScene().Mac)

    rsp = xfer.GetToString()
    json = ParseJson(rsp)
    ?"json returned from qr task" json

    if json <> invalid
        ?"Response from User Task " json
        if json.has_playlist = invalid or json.has_playlist = false
            m.top.isError = true
        else
            lastUpdatedStr = json.last_updated
            if lastUpdatedStr <> invalid and lastUpdatedStr <> ""
                spaceIndex = Instr(0, lastUpdatedStr, " ")
                if spaceIndex > 0
                    datePart = Left(lastUpdatedStr, spaceIndex - 1)
                    timePart = Mid(lastUpdatedStr, spaceIndex + 1)

                  y = val(Mid(datePart, 1, 4))
mo = val(Mid(datePart, 6, 2))
d = val(Mid(datePart, 9, 2))

h = val(Mid(timePart, 1, 2))
mi = val(Mid(timePart, 4, 2))
s = val(Mid(timePart, 7, 2))

' Convert to accurate Unix timestamp
ts = ToUnixTimestamp(y, mo, d, h, mi, s)

lastDate = CreateObject("roDateTime")
lastDate.FromSeconds(ts)

now = CreateObject("roDateTime")
diffSecs = now.AsSeconds() - lastDate.AsSeconds()

?"lastDate: " lastDate.AsSeconds()
?"now: " now.AsSeconds()
?"diffSecs: " diffSecs

if diffSecs > 15
    m.top.isError = true
else
    ' m.top.isError = false
    m.top.arrayObject = json
end if

                else
                    ?"Invalid datetime format"
                    m.top.isError = true
                end if
            else
                ?"Missing or invalid last_updated"
                m.top.isError = true
            end if
        end if
    else
        ?"Invalid JSON"
        m.top.isError = true
    end if
end function


function ToUnixTimestamp(y as Integer, mo as Integer, d as Integer, h as Integer, mi as Integer, s as Integer) as Integer
    ' Adjust months and years
    if mo <= 2
        y = y - 1
        mo = mo + 12
    end if

    ' Gregorian calendar conversion
    a = Int(y / 100)
    b = Int(a / 4)
    c = 2 - a + b
    e = Int(365.25 * (y + 4716))
    f = Int(30.6001 * (mo + 1))
    jd = c + d + e + f - 1524.5 ' Julian Day

    unixDays = jd - 2440587.5 ' Days since 1970-01-01
    totalSeconds = Int(unixDays * 86400) + (h * 3600) + (mi * 60) + s

    return totalSeconds
end function
