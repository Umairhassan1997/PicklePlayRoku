' LivePlayerScreen — full-screen live TV with channel switching and free-time tracking

sub init()
    m.scene = m.top.getScene()
    m.video = m.top.findNode("liveVideo")
    m.bufferingSpinner = m.top.findNode("bufferingSpinner")
    m.channelOverlay = m.top.findNode("channelOverlay")
    m.channelNumberLabel = m.top.findNode("channelNumberLabel")
    m.channelNameLabel = m.top.findNode("channelNameLabel")
    m.errorLabel = m.top.findNode("errorLabel")
    m.overlayHideTimer = m.top.findNode("overlayHideTimer")
    m.usageTickTimer = m.top.findNode("usageTickTimer")

    m.maxPlaybackRetries = 3
    m.playbackRetryCount = 0
    m.switchInProgress = false

    if m.global.currentChannelIndex = invalid
        m.global.currentChannelIndex = 0
    end if

    m.video.observeField("state", "onVideoStateChanged")
    m.video.observeField("errorCode", "onVideoError")
    m.overlayHideTimer.observeField("fire", "onOverlayHideTimerFire")
    m.usageTickTimer.observeField("fire", "onUsageTickTimerFire")
    m.top.observeField("visible", "onVisibleChanged")

    m.bufferingSpinner.poster.uri = "pkg:/images/loader.png"

    m.top.setFocus(true)
    m.video.setFocus(true)
    playChannel(m.global.currentChannelIndex, true)
end sub

sub onVisibleChanged()
    if m.top.visible
        if not isUserPro() and not HasFreeTimeRemaining()
            onFreeTimeExpired()
            return
        end if
        if isUserPro() or HasFreeTimeRemaining()
            m.video.setFocus(true)
            if m.video.state = "playing"
                ResumeUsageTracking()
                startUsageTickTimer()
            end if
        end if
    else
        ' Pause lifetime timer when another screen covers live TV (e.g. subscription)
        pausePlaybackAndTimer()
    end if
end sub

sub playChannel(channelIndex as Integer, showOverlay as Boolean)
    channel = GetLiveChannel(channelIndex)
    if channel = invalid
        return
    end if

    m.switchInProgress = true
    m.playbackRetryCount = 0
    m.errorLabel.visible = false
    m.global.currentChannelIndex = channelIndex

    ' Reuse the same Video node — stop, swap content, play immediately
    m.video.control = "stop"
    content = CreateObject("roSGNode", "ContentNode")
    content.url = channel.streamUrl
    content.streamformat = "hls"
    content.title = channel.title
    m.video.content = content
    m.video.visible = true
    m.video.control = "play"
    m.video.setFocus(true)

    if showOverlay
        showChannelOverlay(channelIndex, channel.title)
    end if
end sub

sub showChannelOverlay(channelIndex as Integer, channelTitle as String)
    m.channelNumberLabel.text = "Channel " + (channelIndex + 1).ToStr()
    m.channelNameLabel.text = channelTitle
    m.channelOverlay.visible = true
    m.overlayHideTimer.control = "start"
end sub

sub onOverlayHideTimerFire()
    m.channelOverlay.visible = false
    m.overlayHideTimer.control = "stop"
end sub

sub onVideoStateChanged()
    state = m.video.state

    if state = "buffering"
        m.bufferingSpinner.visible = true
        PauseUsageTracking()
        stopUsageTickTimer()
    else if state = "playing"
        m.bufferingSpinner.visible = false
        m.errorLabel.visible = false
        m.switchInProgress = false
        m.playbackRetryCount = 0

        if isUserPro() or HasFreeTimeRemaining()
            ResumeUsageTracking()
            startUsageTickTimer()
        else
            onFreeTimeExpired()
        end if
    else if state = "stopped" or state = "finished" or state = "paused"
        m.bufferingSpinner.visible = false
        PauseUsageTracking()
        stopUsageTickTimer()
    else if state = "error"
        m.bufferingSpinner.visible = false
        PauseUsageTracking()
        stopUsageTickTimer()
        handlePlaybackFailure()
    end if
end sub

sub onVideoError()
    if m.video.state = "error"
        handlePlaybackFailure()
    end if
end sub

sub handlePlaybackFailure()
    if m.playbackRetryCount < m.maxPlaybackRetries
        m.playbackRetryCount = m.playbackRetryCount + 1
        m.video.control = "play"
        return
    end if

    m.errorLabel.visible = true
    m.switchInProgress = false
end sub

sub startUsageTickTimer()
    if isUserPro()
        return
    end if
    m.usageTickTimer.control = "start"
end sub

sub stopUsageTickTimer()
    m.usageTickTimer.control = "stop"
end sub

sub pausePlaybackAndTimer()
    PauseUsageTracking()
    stopUsageTickTimer()
    if m.video <> invalid
        m.video.control = "stop"
    end if
end sub

' Fires every second while video is actively playing (free users only)
sub onUsageTickTimerFire()
    if isUserPro()
        stopUsageTickTimer()
        return
    end if

    if m.global.isPlaying <> true or m.video.state <> "playing"
        return
    end if

    stillHasTime = TickUsageSecond()
    if not stillHasTime
        onFreeTimeExpired()
    end if
end sub

sub onFreeTimeExpired()
    PauseUsageTracking()
    stopUsageTickTimer()
    m.video.control = "stop"
    m.video.visible = false
    m.top.timeExpired = true
    m.scene.callFunc("ShowSubscriptionScreen")
end sub

sub switchToNextChannel()
    nextIndex = GetNextChannelIndex(m.global.currentChannelIndex)
    playChannel(nextIndex, true)
end sub

sub switchToPreviousChannel()
    prevIndex = GetPreviousChannelIndex(m.global.currentChannelIndex)
    playChannel(prevIndex, true)
end sub

function OnKeyEvent(key as String, press as Boolean) as Boolean
    if not press
        return false
    end if

    if key = "right"
        switchToNextChannel()
        return true
    else if key = "left"
        switchToPreviousChannel()
        return true
    else if key = "back"
        ' Keep user in live TV; only stop if they need to leave the player
        if m.video.visible
            m.video.control = "stop"
            m.video.visible = false
        end if
        PauseUsageTracking()
        stopUsageTickTimer()
        return true
    end if

    return false
end function
