-- MC群的软妹 玲音

function c284130816.initial_effect(c)
    -- 灵摆召唤
    aux.AddPendulumProcedure(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    -- 特招限制
    local e2 = Effect.CreateEffect(c)
    e2:SetRange(LOCATION_PZONE)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetTargetRange(1, 0)
    e2:SetTarget(c284130816.specialSummonLimit)
    c:RegisterEffect(e2)

    -- 除外抽卡
    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_REMOVE + CATEGORY_DRAW)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetRange(LOCATION_PZONE)
    e3:SetCountLimit(1)
    e3:SetCost(c284130816.drawCost)
    e3:SetTarget(c284130816.drawTarget)
    e3:SetOperation(c284130816.drawOperation)
    c:RegisterEffect(e3)

    -- 无祭品普招
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e4:SetCode(EFFECT_SUMMON_PROC)
    e4:SetCondition(c284130816.summonCondition)
    c:RegisterEffect(e4)

    local e5 = Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_SUMMON_COST)
    e5:SetOperation(c284130816.summonOperation)
    c:RegisterEffect(e5)

    local e6 = e4:Clone(c)
    e6:SetCode(EFFECT_SET_PROC)
    c:RegisterEffect(e6)

    local e7 = e5:Clone(c)
    e7:SetCode(EFFECT_MSET_COST)
    c:RegisterEffect(e7)

    -- 加入手卡
    local e8 = Effect.CreateEffect(c)
    e8:SetCategory(CATEGORY_TOHAND)
    e8:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e8:SetCode(EVENT_SUMMON_SUCCESS + EVENT_SPSUMMON_SUCCESS + EVENT_FLIP_SUMMON_SUCCESS)
    e8:SetCategory(CATEGORY_TOHAND)
    e8:SetTarget()
    e8:SetOperation()
    c:RegisterEffect(e8)
end

function c284130816.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130816.specialSummonLimit(e, c)
    return not c284130816.filter(c)
end

function c284130816.drawFilter(c)
    return c284130816.filter(c) and Card.IsAbleToRemoveAsCost(c)
end

function c284130816.drawCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c284130816.drawFilter, tp, LOCATION_HAND, 0, 1, nil) and Duel.CheckLPCost(tp, 1000)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_REMOVE)
    local g = Duel.SelectMatchingCard(tp, c284130816.drawFilter, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.Remove(g, POS_FACEUP, REASON_COST)
    Duel.PayLPCost(tp, 1000)
end

function c284130816.drawTarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsPlayerCanDraw(tp)
    end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(2)
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, tp, 1)
end

function c284130816.drawOperation(e, tp, eg, ep, ev, re, r, rp)
    if not e:GetHandler():IsRelateToEffect(e) then
        return
    end
    local p, d = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER, CHAININFO_TARGET_PARAM)
    Duel.draw(p, d, REASON_EFFECT)
end

function c284130816.summonCondition(e, c, minc)
    if c == nil then
        return true
    end
    return minc == 0 and c:GetLevel() > 4 and Duel.GetLocationCount(c:GetControler(), LOCATION_MZONE) > 0
end

function c284130816.summonOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local e = Effect.CreateEffect(c)
    e:SetType(EFFECT_TYPE_SINGLE)
    e:SetCode(EFFECT_CHANGE_LEVEL)
    e:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e:SetRange(LOCATION_MZONE)
    e:SetCondition(c284130816.summonOperationCondition)
    e:SetValue(4)
    e:SetReset(RESET_EVENT + 0xff0000)
end

function c284130816.summonOperationCondition(e)
    return e:GetHandler():GetMaterialCount() == 0 and bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_NORMAL) == SUMMON_TYPE_NORMAL
end

function c284130816.toHandTarget(e, tp, eg, ep, ev, re, r, rp, chk)
end

function c284130816.toHandOperation(e, tp, eg, ep, ev, re, r, rp, chk)
end