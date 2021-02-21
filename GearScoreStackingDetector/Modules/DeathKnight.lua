local ADDON_NAME, namespace = ...

local TALENT_TREE_MAP = {
  [1] = "BLOOD",
  [2] = "FROST",
  [3] = "UNHOLY"
}

local function getGsStackedForBlood(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
--    local _, _, _, _, _, _, itemSubType, _, _, _, _, _, _, _, _, _, _ = GetItemInfo(item)

    if ( namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or (namespace.common.statsContainAgility(itemStats) and not namespace.common.statsContainArp(itemStats))
      or (namespace.common.isAnyWeapon(id) and namespace.common.statsContainAgility(itemStats))
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedForFrost(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or namespace.common.statsContainDefense(itemStats)
      or (not namespace.common.isAnyWeapon(id) and namespace.common.statsContainAgility(itemStats) and not namespace.common.statsContainArp(itemStats))
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedForUnholy(itemLinks)
  local gsStackedItemsCount = 0
  
  for id, item in pairs(itemLinks) do
    local itemStats = GetItemStats(item)
    
    if ( namespace.common.statsContainIntelect(itemStats)
      or namespace.common.statsContainSpirit(itemStats)
      or namespace.common.statsContainDefense(itemStats)
      or namespace.common.statsContainResilience(itemStats)
      or (namespace.common.statsContainAgility(itemStats) and not namespace.common.statsContainArp(itemStats))
      or (namespace.common.isAnyWeapon(id) and namespace.common.statsContainAgility(itemStats))
    ) then
      gsStackedItemsCount = gsStackedItemsCount + 1
    end
  end
  
  return gsStackedItemsCount
end

local function getGsStackedItemsCount(itemLinks, dominantTalentTreeId)
  local role = TALENT_TREE_MAP[dominantTalentTreeId]
  
  if role == "BLOOD" then
    return getGsStackedForBlood(itemLinks)
  end
  
  if role == "FROST" then
    return getGsStackedForFrost(itemLinks)
  end
  
  if role == "UNHOLY" then
    return getGsStackedForUnholy(itemLinks)
  end
end

namespace.DK = {}
namespace.DK.getGsStackedItemsCount = getGsStackedItemsCount