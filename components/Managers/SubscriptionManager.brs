' SubscriptionManager — subscription products and pro-user state

function GetMonthlySubscriptionProductId() as String
    return "Comfort_Couch_Monthly"
end function

function GetYearlySubscriptionProductId() as String
    return "Comfort_Couch_Yearly"
end function

function GetMonthlySubscriptionTitle() as String
    return "Comfort Couch Monthly"
end function

function GetYearlySubscriptionTitle() as String
    return "Comfort Couch Yearly"
end function

function GetMonthlySubscriptionPrice() as String
    return "4.00"
end function

function GetYearlySubscriptionPrice() as String
    return "36.00"
end function

function IsActiveSubscriptionProduct(productCode as String) as Boolean
    if productCode = invalid
        return false
    end if
    return productCode = GetMonthlySubscriptionProductId() or productCode = GetYearlySubscriptionProductId()
end function

function GetAppScene() as Object
    if m.top <> invalid and m.top.getScene() <> invalid
        return m.top.getScene()
    end if
    return m.top
end function

function isUserPro() as Boolean
    scene = GetAppScene()
    if scene = invalid
        return false
    end if
    return scene.isSubscribed = true
end function

sub OnUserBecamePro()
    ' Pro users are never restricted by the free usage timer
    scene = GetAppScene()
    if scene <> invalid
        scene.isSubscribed = true
    end if
    m.global.isPlaying = false
end sub
