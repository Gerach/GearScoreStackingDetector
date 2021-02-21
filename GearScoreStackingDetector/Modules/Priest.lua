local ADDON_NAME, namespace = ...

local TALENT_TREE_MAP = {
  [1] = "HEALER",
  [2] = "HEALER",
  [3] = "DAMAGE"
}

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

local function getGsStackedForDamage(itemLinks)
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

local function getGsStackedItemsCount(itemLinks, dominantTalentTreeId)
  local role = TALENT_TREE_MAP[dominantTalentTreeId]
  
  if role == "HEALER" then
    return getGsStackedForHealer(itemLinks)
  end
  
  if role == "DAMAGE" then
    return getGsStackedForDamage(itemLinks)
  end
end

namespace.PR = {}
namespace.PR.getGsStackedItemsCount = getGsStackedItemsCount