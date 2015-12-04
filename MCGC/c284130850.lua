--region *.lua
--2015-11-26
--此文件由[BabeLua]插件自动生成

-- MC群融合
function c284130850.initial_effect(c)
    -- 发动
    -- 参考[65331686]毛绒动物·猫头鹰
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCondition()
    e1:SetTarget()
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 墓地起动
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCost()
    e2:SetCondition()
    e2:SetTarget()
    e2:SetOperation()
    c:RegisterEffect(e2)
end

--endregion
