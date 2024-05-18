-- NOTE(Gabriel): Searched up and there is a constant called CONST_ME_ICETORNADO
-- NOTE(Gabriel): https://github.com/otland/forgottenserver/wiki/Constants#MagicEffect
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, COMBAT_ICETORNADO)

local area = createCombatArea(AREA_CIRCLE5X5)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, magicLevel)
   local levelDiv, magicMult, bias = 5, 3.14, 10
   local min = (level / levelDiv) + (magicLevel * magicMult) + bias
   local max = (level / levelDiv) + (magicLevel * magicMult * 2) + bias * 2

   return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local iceStorm = Spell(SPELL_INSTANT)
function iceStorm.onCastSpell(creature, variant)
   -- NOTE(Gabriel): Now, let's do the cool effect stuff!
   -- NOTE(Gabriel): Let's start by just spawning a single effect
   creature:getPosition():sendMagicEffect(CONST_ME_ICETORNADO)

   -- NOTE(Gabriel): Okay, now that is working I can make the cools effect position and timing
   
   
   return combat:execute(creature, variant)
end

iceStorm:name("Ice Storm")
iceStorm:id(6969)
iceStorm:words("frigo")
iceStorm:level(1)
iceStorm:mana(0)
iceStorm:group("attack")
iceStorm:cooldown(2000)
iceStorm:groupCooldown(2000)
iceStorm:isSelfTarget(false)
iceStorm:isAggressive(true)
iceStorm:needLearn(false)
iceStorm:vocation("sorcerer")
iceStorm:register()
