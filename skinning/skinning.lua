local _, cfg = ...
local addon, ns = ...
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check

--Might break this file up in the future.

--local backdrop function
local function CreateBackdrop(frame)
    frame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = cfg.pixelbordersize, 
        insets = {top = 2, left = 2, bottom = 2, right = 2}})
    frame:SetBackdropColor(unpack(cfg.bColor))
    frame:SetBackdropBorderColor(unpack(cfg.bColor))
	if isBeautiful then
		frame:CreateBeautyBorder(cfg.border.size.large)
		frame:SetBeautyBorderTexture(cfg.border.texture)
		frame:SetBeautyBorderColor(unpack(cfg.border.color))
	end
end

--Some quick cheaty functions for variable bordersizes
local function Borderize(frame) -- style our frame
    if frame then
        frame:CreateBeautyBorder(12)
    end
end

--Skin some of the default UI elements
if isBeautiful then
	--Game Menu (even though you can get the same thing by just rght clicking the minimap)
	a = CreateFrame("Frame")
	a:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_LOGIN" then
			if (IsAddOnLoaded('Aurora')) then
				return
			else
				GameMenuButtonHelp:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonHelp:SetBeautyBorderPadding(1)
				GameMenuButtonHelp:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonStore:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonStore:SetBeautyBorderPadding(1)
				GameMenuButtonStore:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonOptions:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonOptions:SetBeautyBorderPadding(1)
				GameMenuButtonOptions:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonUIOptions:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonUIOptions:SetBeautyBorderPadding(1)
				GameMenuButtonUIOptions:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonKeybindings:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonKeybindings:SetBeautyBorderPadding(1)
				GameMenuButtonKeybindings:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonMacros:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonMacros:SetBeautyBorderPadding(1)
				GameMenuButtonMacros:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonAddons:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonAddons:SetBeautyBorderPadding(1)
				GameMenuButtonAddons:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonLogout:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonLogout:SetBeautyBorderPadding(1)
				GameMenuButtonLogout:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonQuit:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonQuit:SetBeautyBorderPadding(1)
				GameMenuButtonQuit:SetBeautyBorderTexture(cfg.border.texture)
				
				GameMenuButtonContinue:CreateBeautyBorder(cfg.border.size.large)
				GameMenuButtonContinue:SetBeautyBorderPadding(1)
				GameMenuButtonContinue:SetBeautyBorderTexture(cfg.border.texture)
			end
			
			StaticPopup1Button1:CreateBeautyBorder(cfg.border.size.large)
			StaticPopup1Button1:SetBeautyBorderPadding(1)
			StaticPopup1Button1:SetBeautyBorderTexture(cfg.border.texture)
			
			StaticPopup1Button2:CreateBeautyBorder(cfg.border.size.large)
			StaticPopup1Button2:SetBeautyBorderPadding(1)
			StaticPopup1Button2:SetBeautyBorderTexture(cfg.border.texture)
			
			DropDownList1MenuBackdrop:CreateBeautyBorder(cfg.border.size.large)
			DropDownList1MenuBackdrop:SetBeautyBorderPadding(-1)
			DropDownList1MenuBackdrop:SetBeautyBorderTexture(cfg.border.texture)
			
			DropDownList2MenuBackdrop:CreateBeautyBorder(cfg.border.size.large)
			DropDownList2MenuBackdrop:SetBeautyBorderPadding(-1)
			DropDownList2MenuBackdrop:SetBeautyBorderTexture(cfg.border.texture)
		end
	end)
	a:RegisterEvent("PLAYER_LOGIN")
	a:RegisterEvent("PLAYER_ENTERING_WORLD")
		a:RegisterEvent("ADDON_LOADED")

	--Tooltips
	if not IsAddOnLoaded("Aurora") then --quick check for aurora
		GameTooltipStatusBar:CreateBeautyBorder(cfg.border.size.medium)
		GameTooltipStatusBar:SetBeautyBorderPadding(2)
		GameTooltipStatusBar:SetBeautyBorderTexture(cfg.border.texture)
	end
	GameTooltip:CreateBeautyBorder(cfg.border.size.large)
	GameTooltip:SetBeautyBorderPadding(-1.5)
	GameTooltip:SetBeautyBorderTexture(cfg.border.texture)

	ItemRefTooltip:CreateBeautyBorder(cfg.border.size.large)
	ItemRefTooltip:SetBeautyBorderPadding(-2)
	ItemRefTooltip:SetBeautyBorderTexture(cfg.border.texture)

	ItemRefCloseButton:CreateBeautyBorder(10)
	ItemRefCloseButton:SetBeautyBorderPadding(-6)
	ItemRefCloseButton:SetBeautyBorderTexture(cfg.border.texture)
end

--Raid Manager
--[[
if not CompactRaidFrameManager then LoadAddOn("Blizzard_CompactRaidFrames") end

--hide stuff
local buttons = {
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterRoleTank,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterRoleHealer,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterRoleDamager,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup1,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup2,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup3,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup4,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup5,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup6,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup7,
	CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup8,
	CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll,
	CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck,
	CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton,
	CompactRaidFrameManagerDisplayFrameLockedModeToggle,
	CompactRaidFrameManagerDisplayFrameHiddenModeToggle,
	CompactRaidFrameManagerDisplayFrameConvertToRaid
}
CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton.SetNormalTexture = function() end
for _, button in pairs(buttons) do
	for i = 1, 3 do
		select(i, button:GetRegions()):SetAlpha(0)
	end
end

for i = 1, 8 do
	select(i, CompactRaidFrameManager:GetRegions()):Hide()
end
select(1, CompactRaidFrameManagerDisplayFrameFilterOptions:GetRegions()):Hide()
select(1, CompactRaidFrameManagerDisplayFrame:GetRegions()):Hide()
select(4, CompactRaidFrameManagerDisplayFrame:GetRegions()):Hide()

local bd = CreateFrame("Frame", nil, CompactRaidFrameManager)
bd:SetPoint("TOPLEFT", CompactRaidFrameManager, "TOPLEFT")
bd:SetPoint("BOTTOMRIGHT", CompactRaidFrameManager, "BOTTOMRIGHT", -9, 9)

--now we skin it and yes it's really this simple :)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterRoleTank)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterRoleHealer)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterRoleDamager)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup1)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup2)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup3)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup4)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup5)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup6)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup7)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameFilterOptionsFilterGroup8)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateRolePoll)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameLeaderOptionsInitiateReadyCheck)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameLockedModeToggle)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameHiddenModeToggle)
CreateBackdrop(CompactRaidFrameManagerDisplayFrameConvertToRaid)
CreateBackdrop(CompactRaidFrameManager)
CompactRaidFrameManagerToggleButton:SetNormalTexture("Interface\\AddOns\\BobUI\\media\\buttons\\RaidPanel-Toggle")

]]

--This is how you skin the default raid frames
f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
	if event == "GROUP_ROSTER_UPDATE" then
		for i = 1, 5 do -- Party Frames
			Borderize(_G["CompactPartyFrameMember" .. i])
		end
		for i = 1, 80 do -- Raid Frames
			Borderize(_G["CompactRaidFrame" .. i])
		end
		for i = 1, 5 do -- Raid Frames Group 1
			Borderize(_G["CompactRaidGroup1Member" .. i])
		end
		for i = 1, 5 do -- Raid Frames Group 2
			Borderize(_G["CompactRaidGroup2Member" .. i])
		end
		for i = 1, 5 do -- Raid Frames Group 3
			Borderize(_G["CompactRaidGroup3Member" .. i])
		end
		for i = 1, 5 do -- Raid Frames Group 5
			Borderize(_G["CompactRaidGroup4Member" .. i])
		end
		for i = 1, 5 do -- Raid Frames Group 6
			Borderize(_G["CompactRaidGroup5Member" .. i])
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		--Set the default raid frame options to how we want them
		SetCVar("useCompactPartyFrames", 1)
		SetCVar("raidOptionShowBorders", 0)
		SetCVar("raidFramesDisplayPowerBars", 1)
		SetCVar("raidFramesDisplayClassColor", 1)
	end
end)
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("ADDON_LOADED")