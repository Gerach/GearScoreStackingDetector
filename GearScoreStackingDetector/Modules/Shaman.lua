local ADDON_NAME, namespace = ...

local TALENT_TREE_MAP = {
  [1] = "DAMAGE_SPELLPOWER",
  [2] = "DAMAGE_AGILITY",
  [3] = "HEALER"
}

local function getGsStackedForHealer(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainDefense(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainAgility(itemStats)
      or namespace.common.statsContainStrength(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedItemsCount(itemLinks, dominantTalentTreeId)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
--    local _, _, _, _, _, _, itemSubType, _, _, _, _, _, _, _, _, _, _ = GetItemInfo(item)
    
    if ( namespace.common.statsContainStrength(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end

  return gsStackedItemsCount
end

namespace.S = {}
namespace.S.getGsStackedItemsCount = getGsStackedItemsCount