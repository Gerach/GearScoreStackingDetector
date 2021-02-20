local ADDON_NAME, namespace = ...

local TALENT_TREE_MAP = {
  [1] = "DAMAGE",
  [2] = "DAMAGE",
  [3] = "TANK"
}

local function getGsStackedForDamage(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainDefense(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainAgility(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedForTank(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainResilience(itemStats)
      or namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainAgility(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedItemsCount(itemLinks, dominantTalentTreeId)
  local role = TALENT_TREE_MAP[dominantTalentTreeId]
  
  if role == "DAMAGE" then
    return getGsStackedForDamage(itemLinks)
  end
  
  if role == "TANK" then
    return getGsStackedForTank(itemLinks)
  end
end

namespace.W = {}
namespace.W.getGsStackedItemsCount = getGsStackedItemsCount