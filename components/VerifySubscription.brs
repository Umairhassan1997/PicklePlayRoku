sub VerifySubscription()
    ' Subscriptions are not offered — treat all users as subscribed
    m.top.isSubscribed = true
    OnSubscriptionCheckFinished()
end sub

sub OnSubscriptionCheckFinished()
    if m.global.launchRoutePending = true
        m.global.launchRoutePending = false
        scene = m.top.getScene()
        if scene <> invalid
            scene.callFunc("RouteOnLaunch")
        end if
    end if
end sub

sub onGetPurchasesForChecking(event as object)
    ' No-op — ChannelStore purchase checks disabled while subscriptions are off
    OnSubscriptionCheckFinished()
end sub

function onRequestStatus()
    OnSubscriptionCheckFinished()
end function
