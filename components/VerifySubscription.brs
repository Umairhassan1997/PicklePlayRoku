sub VerifySubscription()

    m.order_title = GetMonthlySubscriptionTitle()
    m.order_identifier = GetMonthlySubscriptionProductId()
    m.order_price = GetMonthlySubscriptionPrice()
  
    
    
    m.global.AddField("channelStorecheck", "node", false)
    m.global.channelStorecheck = CreateObject("roSGNode", "ChannelStore")
    m.global.channelStorecheck.command = "getPurchases"
    m.global.channelStorecheck.ObserveField("purchases", "onGetPurchasesForChecking")

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

    ?"onGetPurchasesForChecking"
    m.global.channelStorecheck.UnobserveField("purchases")
    purchases = event.GetData()
    flag =0
    if purchases.GetChildCount() > 0
        allPurchases = purchases.GetChildren(-1, 0)
        datetime = CreateObject("roDateTime")
        utimeNow = datetime.AsSeconds()
        

        for each purchase in allPurchases
            
            if IsActiveSubscriptionProduct(purchase.code)
                
                datetime.FromISO8601String(purchase.expirationDate)
                utimeExpire = datetime.AsSeconds()
                m.expireTime = utimeExpire.ToStr()

                if utimeExpire > utimeNow
                   m.top.isSubscribed=true
                   OnSubscriptionCheckFinished()
                    return
                else  if purchase.inDunning="true" 
                    request = {}
                    request.command = "DoRecovery"
                    m.store = CreateObject("roSGNode", "ChannelStore")
                    m.store.observeField("requestStatus", "onRequestStatus")
                    m.store.request = request
                    OnSubscriptionCheckFinished()
                    return


                else
                    m.top.isSubscribed=false
                    OnSubscriptionCheckFinished()
                    return

              
                  
                end if


          

            end if
        end for
    else
        m.top.isSubscribed=false

       
    end if
    
    OnSubscriptionCheckFinished()

end sub

function onRequestStatus()
    print "onRequestStatus"
    requestStatus = m.store.requestStatus
    if requestStatus = Invalid
      m.top.isSubscribed=false
      OnSubscriptionCheckFinished()
    else if requestStatus.status <> 1
        m.top.isSubscribed=false
        OnSubscriptionCheckFinished()
    else
       VerifySubscription()
   end if
end function
