-- NOTE(Gabriel): Searched up and there is a constant called CONST_ME_ICETORNADO
-- NOTE(Gabriel): https://github.com/otland/forgottenserver/wiki/Constants#MagicEffect
local combat = {}

-- NOTE(Gabriel): I don't know how to explain this, but I guess I figured it out.
-- NOTE(Gabriel): Each effect takes two or three cells.
local area = {
	{
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 1, 1, 0, 0, 0, 0},
		{1, 1, 0, 2, 0, 1, 1},
		{0, 1, 1, 0, 0, 0, 0},
		{0, 0, 1, 1, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 0}
	},
	{
		{0, 0, 1, 0, 1, 0, 0},
		{0, 0, 1, 0, 1, 0, 0},
		{0, 0, 0, 1, 1, 1, 0},
		{0, 0, 1, 2, 1, 0, 0},
		{0, 1, 1, 1, 1, 1, 0},
		{0, 0, 1, 0, 1, 0, 0},
		{0, 0, 0, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 1, 1, 0, 0},
		{0, 0, 0, 1, 1, 0, 0},
		{0, 1, 1, 0, 0, 0, 1},
		{1, 1, 0, 2, 1, 0, 1},
		{0, 0, 0, 1, 1, 0, 1},
		{0, 0, 0, 0, 1, 0, 0},
		{0, 0, 0, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 1, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 0},
		{0, 0, 1, 1, 0, 0, 0},
		{1, 1, 1, 2, 1, 0, 0},
		{0, 1, 1, 1, 1, 0, 0},
		{0, 0, 1, 1, 1, 0, 0},
		{0, 0, 1, 1, 0, 0, 0}
	},
	{
		{0, 0, 0, 1, 1, 0, 0},
		{0, 0, 0, 1, 1, 0, 0},
		{0, 1, 1, 0, 0, 0, 1},
		{1, 1, 0, 2, 1, 0, 1},
		{0, 0, 0, 1, 1, 0, 1},
		{0, 0, 0, 0, 1, 0, 0},
		{0, 0, 0, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 1, 1, 0, 0, 0, 0},
		{1, 1, 0, 2, 0, 1, 1},
		{0, 1, 1, 0, 1, 1, 0},
		{0, 0, 1, 1, 0, 1, 0},
		{0, 0, 0, 1, 0, 0, 0}
	},
	{
		{0, 0, 1, 0, 1, 0, 0},
		{0, 0, 1, 0, 1, 1, 0},
		{0, 0, 0, 1, 1, 1, 1},
		{0, 0, 1, 2, 1, 0, 0},
		{0, 1, 1, 1, 1, 1, 0},
		{0, 0, 1, 0, 1, 0, 0},
		{0, 0, 0, 0, 0, 0, 0}
	},
	{
		{0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0},
		{0, 1, 1, 0, 0, 0, 0},
		{1, 1, 0, 2, 0, 1, 1},
		{1, 1, 1, 0, 0, 0, 0},
		{0, 1, 1, 1, 0, 0, 0},
		{0, 0, 0, 1, 0, 0, 0}
	},
	{
		{0, 1, 1, 0, 1, 0, 0},
		{1, 1, 1, 0, 1, 0, 0},
		{1, 1, 0, 1, 1, 1, 0},
		{0, 0, 1, 2, 1, 1, 1},
		{0, 1, 1, 1, 1, 1, 1},
		{0, 0, 1, 0, 1, 1, 1},
		{0, 0, 0, 0, 0, 0, 0}
	}
}

--[[
function onGetFormulaValues(creature, level, magicLevel)
    local levelDiv, magicMult, bias = 5, 3.14, 10
    local min = (level / levelDiv) + (magicLevel * magicMult) + bias
    local max = (level / levelDiv) + (magicLevel * magicMult * 2) + bias * 2
      
    return -min, -max
end
]]--

-- NOTE(Gabriel): We need to initialize a new combat for each pattern :/
for i = 1, #area do
	combat[i] = Combat()
	combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
	combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)

	combat[i]:setArea(createCombatArea(area[i]))
	--combat[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end

local iceStorm = Spell(SPELL_INSTANT)
function iceStorm.onCastSpell(creature, variant)
   local cooldown = 200
   
   for i = 1, #area do
      addEvent(function()
	    -- NOTE(Gabriel): Iterate over combats
	    combat[i]:execute(creature, variant)
      end, (cooldown * i) - cooldown)
   end

   return true
end

iceStorm:name("Ice Storm")
iceStorm:id(69)
iceStorm:words("frigo")
iceStorm:level(1)
iceStorm:mana(0)
iceStorm:group("attack")
iceStorm:cooldown(50)
iceStorm:groupCooldown(50)
iceStorm:isSelfTarget(false)
iceStorm:isAggressive(true)
iceStorm:needLearn(false)
iceStorm:vocation("sorcerer")
iceStorm:register()
