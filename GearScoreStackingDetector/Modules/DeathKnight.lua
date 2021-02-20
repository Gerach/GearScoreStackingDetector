local ADDON_NAME, namespace = ...

local TALENT_TREE_MAP = {
  [1] = "DAMAGE_TANK_STRENGTH",
  [2] = "DAMAGE",
  [3] = "DAMAGE"
}

local function getGsStackedForHybrid(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
--    local _, _, _, _, _, _, itemSubType, _, _, _, _, _, _, _, _, _, _ = GetItemInfo(item)
    
    if ( namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
      or namespace.common.statsContainResilience(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedForDamage(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
      or namespace.common.statsContainDefense(itemStats)
      or namespace.common.statsContainResilience(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedItemsCount(itemLinks, dominantTalentTreeId)
  local role = TALENT_TREE_MAP[dominantTalentTreeId]
  
  if role == "DAMAGE_TANK_STRENGTH" then
    return getGsStackedForHybrid(itemLinks)
  end
  
  if role == "DAMAGE" then
    return getGsStackedForDamage(itemLinks)
  end
end

namespace.DK = {}
namespace.DK.getGsStackedItemsCount = getGsStackedItemsCount