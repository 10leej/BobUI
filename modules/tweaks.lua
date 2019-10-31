local _, cfg = ... --import config
local addon, ns = ... --get addon namespace

--RaidFrameResizer
local n,w,h="CompactUnitFrameProfilesGeneralOptionsFrame" h,w=
_G[n.."HeightSlider"],
_G[n.."WidthSlider"]
h:SetMinMaxValues(1,150)
w:SetMinMaxValues(1,150)


--Max Camera distance increase
if cfg.MaxCamera then
	function SetMaxCameraDistance()
		SetCVar("cameraDistanceMaxZoomFactor", 3.5)
	end
	local addon = CreateFrame("Frame")

	--Register
	addon:RegisterEvent("PLAYER_ENTERING_WORLD")
	--Call
	addon:SetScript("OnEvent", function(self, event, ...)
		SetMaxCameraDistance()
	end)
end
--auto repair and sell trash
if cfg.AutoVendor then
	local g = CreateFrame("Frame")
	g:RegisterEvent("MERCHANT_SHOW")
	g:SetScript("OnEvent", function()
	local bag, slot
	  for bag = 0, 4 do
		for slot = 0, GetContainerNumSlots(bag) do
		  local link = GetContainerItemLink(bag, slot)
		  if link and (select(3, GetItemInfo(link)) == 0) then
			UseContainerItem(bag, slot)
		  end
		end
	  end
	  if(CanMerchantRepair()) then
		local cost = GetRepairAllCost()
		if cost > 0 then
		  local money = GetMoney()
		  if money > cost then
			RepairAllItems()
			print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
		  else
			print("Not enough gold to cover the repair cost.")
		  end
		end
	  end
	end)
end
 --load message
local frame=CreateFrame("Frame")
local elapsed=0
local NUMBER_OF_SECONDS_TO_WAIT= 6
frame:SetScript("OnUpdate", function (self, delta)
	elapsed = elapsed+delta
	if elapsed > NUMBER_OF_SECONDS_TO_WAIT then
		self:SetScript("OnUpdate", nil)
		print("BobUI is now loaded. Type /bobui for info")
	end
end)

--Some slash commands
SlashCmdList["TICKET"] = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/??"
SLASH_TICKET2 = "/gm"

SlashCmdList["READYCHECK"] = function() DoReadyCheck() end
SLASH_READYCHECK1 = '/rc'
SLASH_READYCHECK2 = '/??'

SlashCmdList["CLCE"] = function() CombatLogClearEntries() end
SLASH_CLCE1 = "/clc"

SlashCmdList['RELOADUI'] = function() ReloadUI() end
SLASH_RELOADUI1 = '/rl'
SLASH_RELOADUI2 = '/??'

local function Setup() --call this a function to do stuff
	--Chat frames
	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("BOTTOMRIGHT", UIParent, -8, 4)
	ChatFrame1:SetSize(390,110)
	FCF_SetLocked(ChatFrame1, true)

	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetPoint("BOTTOMLEFT", UIParent, 4, 4)
	ChatFrame3:SetSize(390,110)
	FCF_SetLocked(ChatFrame3, true)
	--Initialize Setup
end
--[[
local f = CreateFrame("frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:SetScript("OnEvent", function(self, event, ...)
	Setup() --And...... GO!
end)
]]
SlashCmdList["BOBUI"] = function() Setup() end --hmm our slash command doesn't work?
SLASH_BOBUI1 = "/bobsetup"
SLASH_BOBUI2 = "/uisetup"

SlashCmdList["ABOUT"] = function()
	print("BobUI v6.1 developed by 10leej@wowinterface.com")
	print(" ")
    print("Slash Commands:")
    print("/rl --for UI Reload")
    print("/gm --to open Support/Help")
    print("/rc --run a Ready Check")
    print("/clc --Clears Combat log entries")
	print(" ")
	print("Features:")
	print("Auto Repair (with guild support filterable by if in raid group)")
	print("Auto Sells Greys")
	print("Clickable URL Links in chat")
	print("Pull Timer using /pull")
	print(" ")
	print("Have fun and enjoy playing.")
end
SLASH_ABOUT1 = "/about"
SLASH_ABOUT2 = "/bobui"
