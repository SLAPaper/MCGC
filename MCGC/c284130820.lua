-- MC群的触手 玲音
function c284130820.initial_effect(c)
    -- 仪式召唤
    c:EnableReviveLimit()

    -- 特招效果
    e1 = Effect.CreateEffect(c)
    e1:SetCateGory(CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetTarget(c284130820.toDeckTarget)
    e1:SetOperation(c284130820.toDeckOperation)

    -- 丢弃效果
    e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SEARCH + CATEGORY_TOHAND)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetRange(LOCATION_HAND)
    e2:SetCost(c284130820.toHandCost)
    e2:SetTarget(c284130820.toHandTarget)
    e2:SetOperation(c284130820.toHandOperation)

end

function c284130820.toDeckTarget(e, tp, eg, ep, ev, re, r, rp, chk)

end

function c284130820.toDeckOperation(e, tp, eg, ep, ev, re, r, rp, chk)

end

function c284130820.toHandCost(e, tp, eg, ep, ev, re, r, rp, chk)

end

function c284130820.toHandTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)

end

function c284130820.toHandOperation(e, tp, eg, ep, ev, re, r, rp)

end