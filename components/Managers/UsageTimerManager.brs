' UsageTimerManager — lifetime free viewing allowance (registry-backed)

function GetFreeWatchLimitSeconds() as Integer
    return 600 ' 10 minutes total for free users
end function

function GetUsageRegistrySection() as String
    return "LiveTV"
end function

function GetUsageRegistryKey() as String
    return "remainingSeconds"
end function

sub InitUsageTimer()
    m.global.AddField("launchRoutePending", "boolean", false)
    m.global.AddField("remainingSeconds", "integer", false)
    m.global.AddField("isPlaying", "boolean", false)
    m.global.AddField("currentChannelIndex", "integer", false)

    sec = CreateObject("roRegistrySection", GetUsageRegistrySection())
    if sec.Exists(GetUsageRegistryKey())
        m.global.remainingSeconds = sec.Read(GetUsageRegistryKey()).ToInt()
    else
        m.global.remainingSeconds = GetFreeWatchLimitSeconds()
        SaveRemainingSeconds(m.global.remainingSeconds)
    end if

    if m.global.currentChannelIndex = invalid
        m.global.currentChannelIndex = 0
    end if
    m.global.isPlaying = false
end sub

sub SaveRemainingSeconds(seconds as Integer)
    if seconds < 0
        seconds = 0
    end if
    m.global.remainingSeconds = seconds
    sec = CreateObject("roRegistrySection", GetUsageRegistrySection())
    sec.Write(GetUsageRegistryKey(), seconds.ToStr())
    sec.Flush()
end sub

function GetRemainingSeconds() as Integer
    if m.global.remainingSeconds = invalid
        InitUsageTimer()
    end if
    return m.global.remainingSeconds
end function

function HasFreeTimeRemaining() as Boolean
    if isUserPro()
        return true
    end if
    return GetRemainingSeconds() > 0
end function

' Consume one second of free time. Returns false when time is exhausted.
function TickUsageSecond() as Boolean
    if isUserPro()
        return true
    end if

    remaining = GetRemainingSeconds()
    if remaining <= 0
        SaveRemainingSeconds(0)
        return false
    end if

    remaining = remaining - 1
    SaveRemainingSeconds(remaining)
    return remaining > 0
end function

sub PauseUsageTracking()
    m.global.isPlaying = false
end sub

sub ResumeUsageTracking()
    if isUserPro()
        return
    end if
    if HasFreeTimeRemaining()
        m.global.isPlaying = true
    end if
end sub
