' UsageTimerManager — viewing allowance (unlimited; subscriptions not offered)

function GetFreeWatchLimitSeconds() as Integer
    return -1 ' unlimited
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

    ' Clear any previously saved free-time countdown
    m.global.remainingSeconds = -1
    sec = CreateObject("roRegistrySection", GetUsageRegistrySection())
    if sec.Exists(GetUsageRegistryKey())
        sec.Delete(GetUsageRegistryKey())
        sec.Flush()
    end if

    if m.global.currentChannelIndex = invalid
        m.global.currentChannelIndex = 0
    end if
    m.global.isPlaying = false
end sub

sub SaveRemainingSeconds(seconds as Integer)
    m.global.remainingSeconds = seconds
end sub

function GetRemainingSeconds() as Integer
    if m.global.remainingSeconds = invalid
        InitUsageTimer()
    end if
    return m.global.remainingSeconds
end function

function HasFreeTimeRemaining() as Boolean
    return true
end function

' No-op — viewing time is unlimited
function TickUsageSecond() as Boolean
    return true
end function

sub PauseUsageTracking()
    m.global.isPlaying = false
end sub

sub ResumeUsageTracking()
    ' No usage tracking while subscriptions are disabled
end sub
