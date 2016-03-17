-- region *.lua
-- Date 2016-03-14
-- 此文件由[BabeLua]插件自动生成

-- 熊孩子的狂欢节！
function c84130861.initial_effect(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    -- 破坏触发
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_DESTROYED)
    e2:SetCondition(c84130861.triggerCondition)
    e2:SetOperation(c84130861.triggerOperation)
    c:RegisterEffect(e2)

    -- 破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DESTROY)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCountLimit(1)
    e2:SetCondition()
    e2:SetTarget()
    e2:SetOperation()
    c:RegisterEffect(e2)
end

function c84130861.triggerCondition(e, tp, eg, ep, ev, re, r, rp)
    return eg:IsExists( function(c)
        return c:GetControler() == tp and c:IsType(TYPE_SPELL + TYPE_TRAP)
    end , 1, nil)
end

function c84130861.triggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCode(EVENT_PHASE + PHASE_END)
    e1:SetLabelObject(eg)
    e1:SetCondition(c84130861.acivateCondition)
    e1:SetCost(c84130861.activateCost)
    e1:SetOperation(c84130861.activateOperation)
    e1:SetReset(RESET_PHASE + PHASE_END)
    e:GetHandler():RegisterEffect(e1)
end

function c84130861.activateCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetLocationCount(tp, LOCATION_SZONE, tp, LOCATION_REASON_TOFIELD) >= eg:FilterCount( function(c)
        return c:GetControler() == tp
    end , nil)
end

function c84130861.activateCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.CheckLPCost(tp, 1000)
    end
    Duel.PayLPCost(tp, 1000)
end

function c84130861.activateOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = e:GetLabelObject():Filter(function(c)
        return c:GetControler() == tp
    end , nil)
    Duel.SSet(tp, g, tp)
end

-- endregion
