local ADDON_NAME, namespace = ...

local GEAR_SLOTS = {
  ["HEAD"] = 1,
  ["NECK"] = 2,
  ["SHOULDERS"] = 3,
  ["CHEST"] = 5,
  ["WAIST"] = 6,
  ["PANTS"] = 7,
  ["BOOTS"] = 8,
  ["BRACERS"] = 9,
  ["HANDS"] = 10,
  ["RING_UPPER"] = 11,
  ["RING_LOWER"] = 12,
  ["TRINKET_UPPER"] = 13,
  ["TRINKET_LOWER"] = 14,
  ["CLOAK"] = 15,
  ["MAIN_HAND"] = 16,
  ["OFF_HAND"] = 17,
  ["RELIC"] = 18
}

local function isAnyWeapon(itemId)
  if (GEAR_SLOTS.MAIN_HAND == itemId) or (GEAR_SLOTS.OFF_HAND == itemId) then
    return true
  end
  return false
end


local function getDominantTalentTreeId()
  local dominatingTalentTree = 0
  local dominatingTalentTreePoints = 0
  local currentlyActiveTalentsTab = GetActiveTalentGroup(true, false)
  
  for talentTree=1,3 do
    local name, _, pointsSpent = GetTalentTabInfo(talentTree, true, false, currentlyActiveTalentsTab)
    if (pointsSpent > dominatingTalentTreePoints) then
      dominatingTalentTreePoints = pointsSpent
      dominatingTalentTree = talentTree
    end
  end
  
  return dominatingTalentTree
end


local function statsContainStrength(stats)
  if stats["ITEM_MOD_STRENGTH_SHORT"] then
    return true
  end
  return false
end


local function statsContainIntelect(stats)
  if stats["ITEM_MOD_INTELLECT_SHORT"] then
    return true
  end
  return false
end


local function statsContainAgility(stats)
  if stats["ITEM_MOD_AGILITY_SHORT"] then
    return true
  end
  return false
end


local function statsContainSpirit(stats)
  if stats["ITEM_MOD_SPIRIT_SHORT"] then
    return true
  end
  return false
end

local function statsContainDefense(stats)
  if stats["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] then
    return true
  end
  return false
end

local function statsContainResilience(stats)
  if stats["ITEM_MOD_RESILIENCE_RATING_SHORT"] then
    return true
  end
  return false
end

local function statsContainArp(stats)
  if stats["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] then
    return true
  end
  return false
end

local function statsContainSpellPower(stats)
  if stats["ITEM_MOD_SPELL_POWER_SHORT"] then
    return true
  end
  return false
end

local function statsContainHitRating(stats)
  if stats["ITEM_MOD_HIT_RATING_SHORT"] then
    return true
  end
  return false
end


namespace.common = {}
namespace.common.GEAR_SLOTS = GEAR_SLOTS
namespace.common.isAnyWeapon = isAnyWeapon
namespace.common.getDominantTalentTreeId = getDominantTalentTreeId
namespace.common.statsContainStrength = statsContainStrength
namespace.common.statsContainIntelect = statsContainIntelect
namespace.common.statsContainAgility = statsContainAgility
namespace.common.statsContainSpirit = statsContainSpirit
namespace.common.statsContainDefense = statsContainDefense
namespace.common.statsContainResilience = statsContainResilience
namespace.common.statsContainArp = statsContainArp
namespace.common.statsContainSpellPower = statsContainSpellPower
namespace.common.statsContainHitRating = statsContainHitRating