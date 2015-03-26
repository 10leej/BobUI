--Credits to Monolit and Nightcracker
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace


--Some slash commands
SlashCmdList["TICKET"] = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/??"
SLASH_TICKET2 = "/gm"

SlashCmdList["READYCHECK"] = function() DoReadyCheck() end
SLASH_READYCHECK1 = '/rc'
SLASH_READYCHECK2 = '/??'

SlashCmdList["CHECKROLE"] = function() InitiateRolePoll() end
SLASH_CHECKROLE1 = '/cr'
SLASH_CHECKROLE2 = '/??'

SlashCmdList["CLCE"] = function() CombatLogClearEntries() end
SLASH_CLCE1 = "/clc"

SlashCmdList['RELOADUI'] = function() ReloadUI() end
SLASH_RELOADUI1 = '/rl'
SLASH_RELOADUI2 = '/??'

SlashCmdList["ABOUT"] = function()
	print("BobUI v6.0 developed by 10leej@wowinterface.com")
	print(" ")
    print("Slash Commands:")
    print("/kb --for keybinding")
    print("/rl --for UI Reload")
    print("/gm --to open Support/Help")
    print("/rc --run a Ready Check")
    print("/clc --Clears Combat log entries")
    print("/inc --Runs a countdown in chat. Type /inc with a number behind it to set a custom timer, defaults to 6")
	print(" ")
	print("Features:")
	print("Auto Repair (with guild support filterable by if in raid group)")
	print("Auto Sells Greys")
	print("Clickable URL Links in chat")
	print(" ")
	print("Have fun and enjoy playing.")
end
SLASH_ABOUT1 = "/about"
SLASH_ABOUT2 = "/bobui"

--Pixel Perfection
if not cfg.AutoScaleUI then
    --Manual UI Scaling
	local f = CreateFrame("Frame", nil, UIParent)
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:SetScript("OnEvent", function(self, event)
		UIParent:SetScale(cfg.UIscale)
		f:UnregisterAllEvents()
	end)
end

--Proper Ready Check sound
local ShowReadyCheckHook = function(self, initiator, timeLeft)
	if initiator ~= "player" then PlaySound("ReadyCheck") end
end
hooksecurefunc("ShowReadyCheck", ShowReadyCheckHook)
--RoleCheck auto select
local f=DrC or CreateFrame("Frame","DrC")
f:SetScript("OnEvent",function() 
	if UnitGroupRolesAssigned("player") then 
		StaticPopupSpecial_Hide(RolePollPopup) 
	end 
end) 
f:RegisterEvent("ROLE_POLL_BEGIN")


--Max camera distance, screenshots quality, LFD tooltip fix
local f = CreateFrame"Frame"
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("VARIABLES_LOADED")
f:SetScript("OnEvent", function(self, event)
	SetCVar("profanityFilter",0)
	--SetCVar("showAllEnemyDebuffs",1)
end)
SetCVar("cameraDistanceMax", 50)
SetCVar("cameraDistanceMaxFactor", 3.4)
if LFGSearchStatus then LFGSearchStatus:SetFrameStrata("HIGH") end
if LFDSearchStatus then LFDSearchStatus:SetFrameStrata("HIGH") end

--Auto Screenshot
if cfg.autoshot then
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ACHIEVEMENT_EARNED");
	frame:SetScript("OnEvent", function(self, event, ...) Screenshot() end)
end

--auto repair/sell trash
if cfg.automate then
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
				if IsInGuild() then
					local guildMoney = GetGuildBankWithdrawMoney()
					if guildMoney > GetGuildBankMoney() then
						guildMoney = GetGuildBankMoney()
					end
					if guildMoney > cost and CanGuildBankRepair() then
						RepairAllItems(1)
						print(format("|cfff07100Repair cost covered by G-Bank: %.1fg|r", cost * 0.0001))
					return
					end
				end
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

if cfg.FilterErrors then --module control
--This is ncError by Nightcracker
	local f, o, db = CreateFrame("Frame"), "No error yet.", {
		["mode"] = "whitelist", -- This defines the mode of filtering. Options are whitelist and blacklist.
		[ERR_INV_FULL] = true, -- All errors can be found on http://www.wowwiki.com/WoW_Constants/Errors, this error is for example "Inventory is full.".
		[ERR_DECLINE_GROUP_S ] = true, -- Copy & paste this line and change "" to a value found on the website above to add errors...
		[ERR_DUEL_CANCELLED ] = true, -- ...or you enter the exact error between the quotes like this: "Out of range".
		[ERR_GROUP_JOIN_BATTLEGROUND_FAIL ] = true,
		[ERR_MAIL_TARGET_NOT_FOUND ] = true,
		[ERR_OUT_OF_RANGE ] = true,
		[ERR_VENDOR_HATES_YOU ] = true,
		[ERR_VENDOR_NOT_INTERESTED ] = true,
	}

	-- NO TOUCHY BELOW THIS LINE!
	f:SetScript("OnEvent",function(_,_,e)
		if e=="" then return end
		if db.mode~="whitelist" and not db[e] or db.mode=="whitelist" and db[e] then
		UIErrorsFrame:AddMessage(e,1,0,0) else o=e end
	end)
	SLASH_NCERROR1 = "/error"
	function SlashCmdList.NCERROR() UIErrorsFrame:AddMessage(o,1,0,0) end
	UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	f:RegisterEvent("UI_ERROR_MESSAGE")
end

 --load message
local frame=CreateFrame("Frame")
local elapsed=0
local NUMBER_OF_SECONDS_TO_WAIT= 10
frame:SetScript("OnUpdate", function (self, delta)
	elapsed = elapsed+delta
	if elapsed > NUMBER_OF_SECONDS_TO_WAIT then
		self:SetScript("OnUpdate", nil)
		print("BobUI is now loaded. Type /bobui for info")
	end
end)

--viewport
local f = CreateFrame("Frame", "BobViewport")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PET_BATTLE_OVER")

local function eventHandler(self, event, ...)
    WorldFrame:SetPoint("BOTTOMRIGHT", 0,cfg.ViewPort.bottom)
end
f:SetScript("OnEvent",eventHandler)