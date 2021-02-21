local ADDON_NAME, namespace = ...

local TALENT_TREE_MAP = {
  [1] = "DAMAGE_SPELLPOWER",
  [2] = "DAMAGE_TANK_AGILITY",
  [3] = "HEALER"
}

local function getGsStackedForSpellpower(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainDefense(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or namespace.common.statsContainAgility(itemStats)
      or namespace.common.statsContainStrength(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedForHybrid(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or namespace.common.statsContainSpellPower(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedForHealer(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainDefense(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or namespace.common.statsContainAgility(itemStats)
      or namespace.common.statsContainStrength(itemStats)
      or namespace.common.statsContainHitRating(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedItemsCount(itemLinks, dominantTalentTreeId)
  local role = TALENT_TREE_MAP[dominantTalentTreeId]
  
  if role == "DAMAGE_SPELLPOWER" then
    return getGsStackedForSpellpower(itemLinks)
  end
  
  if role == "DAMAGE_TANK_AGILITY" then
    return getGsStackedForHybrid(itemLinks)
  end
  
  if role == "HEALER" then
    return getGsStackedForHealer(itemLinks)
  end
end

namespace.D = {}
namespace.D.getGsStackedItemsCount = getGsStackedItemsCount