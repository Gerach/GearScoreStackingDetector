local ADDON_NAME, namespace = ...

local TALENT_TREE_MAP = {
  [1] = "DAMAGE",
  [2] = "DAMAGE",
  [3] = "DAMAGE"
}

local function getGsStackedForDamage(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainDefense(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or namespace.common.statsContainStrength(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
      or namespace.common.statsContainAgility(itemStats)
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
end

namespace.M = {}
namespace.M.getGsStackedItemsCount = getGsStackedItemsCount