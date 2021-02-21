local ADDON_NAME, namespace = ...

----------------------------------- Constants ---------------------------------

local RED = {1, 0, 0}
local GREEN = {0, 1, 0}

local CLASSES = {
  ["Death Knight"] = namespace.DK,
  ["Druid"] = namespace.D,
  ["Hunter"] = namespace.H,
  ["Mage"] = namespace.M,
  ["Paladin"] = namespace.P,
  ["Priest"] = namespace.PR,
  ["Rogue"] = namespace.R,
  ["Shaman"] = namespace.S,
  ["Warlock"] = namespace.WL,
  ["Warrior"] = namespace.W
}

----------------------------------- Constants end -----------------------------

----------------------------------- MAIN --------------------------------------

local function isPlayerGsStacking(target, dominantTalentTreeId)
  local playerClass = UnitClass(target)
  if not playerClass then
    return
  end
  
  local itemLinksTable = {}
  for name, id in pairs(namespace.common.GEAR_SLOTS) do
    local itemLink = GetInventoryItemLink(target, id)
    itemLinksTable[id] = itemLink
  end
  
  return CLASSES[playerClass].getGsStackedItemsCount(itemLinksTable, dominantTalentTreeId)
end


local function setGearScoreStackingTooltip(dominantTalentTreeId)
  local gsStackedItems = isPlayerGsStacking("mouseover", dominantTalentTreeId)
  if not gsStackedItems then
    return
  end
  if (gsStackedItems > 0) then
    GameTooltip:AddLine("GS stcked items: " .. gsStackedItems, unpack(RED))
  else
    GameTooltip:AddLine("No GS stacking", unpack(GREEN))
  end
end


local inspectTainted
local f = CreateFrame("frame")
f:SetScript("OnEvent", function(self)
  self:UnregisterEvent("INSPECT_TALENT_READY")
  if inspectTainted then
    NotifyInspect("mouseover")
    inspectTainted = false
    f:RegisterEvent("INSPECT_TALENT_READY")
  else
    local dominantTalentTreeId = namespace.common.getDominantTalentTreeId()
    setGearScoreStackingTooltip(dominantTalentTreeId)
    GameTooltip:Show()
  end
end)

local function inspectAndSetTooltip(target)
  NotifyInspect(target)
  inspectTainted = false
  f:RegisterEvent("INSPECT_TALENT_READY")
end


local function hookSetUnit()
  -- TODO: add check if player is being inspected in ui and return if so
  -- TODO: think of some temporary caching solution
  ClearInspectPlayer()
  
  if (UnitLevel("mouseover") ~= 80) then
    return
  end
  
  local canCompareAchievementsIndex = 1
  if (not CanInspect("mouseover")) or (not CheckInteractDistance("mouseover", canCompareAchievementsIndex)) then
    return
  end
  
  inspectAndSetTooltip("mouseover")
end

----------------------------------- MAIN END ----------------------------------

----------------------------------- Hooks -------------------------------------

GameTooltip:HookScript("OnTooltipSetUnit", hookSetUnit)

hooksecurefunc("NotifyInspect", function() inspectTainted = true end)

----------------------------------- Hooks end ---------------------------------

----------------------------------- Manual ------------------------------------

local function handleManual(command)
  if (command == 'help') then
    print("Gear Score Stacking Detector - written and maintained by Gerach.")
    return
  else
    print("Invalid command")
  end
end

SlashCmdList["GSSD"] = handleManual
SLASH_GSSD1 = "/gssd"

---------------------------------- Manual end ---------------------------------