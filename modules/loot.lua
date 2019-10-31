local _, cfg = ... --import config
local addon, ns = ... --get addon namespace
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check
--[[
if cfg.lootframes then --module control
	--This is based off Game92's !BeautyLoot and Seerah's LovelyLoot
	local frames = LootFrame
	local LootFrame = LootFrame
	local _G = _G -- import globals for faster usage
	
	--backdrop function
	local function CreateBackdrop(frame)
		frame:SetBackdrop({bgFile = cfg.backdrop,edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = cfg.pixelbordersize, 
			insets = {top = 2, left = 2, bottom = 2, right = 2}})
		frame:SetBackdropColor(unpack(cfg.bColor))
		frame:SetBackdropBorderColor(unpack(cfg.bColor))
		if isBeautiful then
			frame:CreateBeautyBorder(cfg.border.size.large)
			frame:SetBeautyBorderTexture(cfg.border.texture)
			frame:SetBeautyBorderColor(unpack(cfg.border.color))
		end
	end

	--put a portrait on it
	local LootTargetPortrait = CreateFrame("PlayerModel", nil, _G["LootFrame"])
	LootTargetPortrait:SetPoint("TOP", _G["LootFrame"], "TOP", -2, -28)
	LootTargetPortrait:SetSize(25*6, 18*2)
	LootTargetPortrait:SetBackdropColor(unpack(cfg.bColor))

	--kill the textures
	local bg, titlebg, portrait, portraitframe, trcorner, tlcorner, top, 
	unknowntitle, topstreak, blcorner, brcorner, bottom, left, right, btncornerL,
	btncornerR, btnbottom, portraitoverlay, title, prevtext, nextext = _G["LootFrame"]:GetRegions()
	
	bg:Hide()
	titlebg:Hide()
	portrait:Hide()
	portraitframe:Hide()
	trcorner:Hide()
	tlcorner:Hide()
	top:Hide()
	topstreak:Hide()
	blcorner:Hide()
	brcorner:Hide()
	bottom:Hide()
	left:Hide()
	right:Hide()
	portraitoverlay:Hide()
	btncornerL:Hide()
	btncornerR:Hide()
	btnbottom:Hide()
	LootFrameInset:Hide()
		
	hooksecurefunc("LootFrame_UpdateButton", function(index)
		local texture, item, quantity, quality, locked, isQuestItem, questId, isActive = GetLootSlotInfo(index)
		_G["LootButton"..index.."IconQuestTexture"]:SetAlpha(0) -- hide that pesky quest item texture
		_G["LootButton"..index.."NameFrame"]:SetAlpha(0) -- hide sucky fagdrops :D
	end)

	--Lets work on the frame now
	--set the backdrop
	CreateBackdrop(LootFrame)

	--rearrange the frame, make it Lovely
	LootFrameUpButton:ClearAllPoints()
	LootFrameUpButton:SetPoint("BOTTOMLEFT", 12, 12)
	LootFrameDownButton:ClearAllPoints()
	LootFrameDownButton:SetPoint("BOTTOMRIGHT", -12, 12)
	prevtext:ClearAllPoints()
	prevtext:SetPoint("LEFT", LootFrameUpButton, "RIGHT", 3, 0)
	nextext:ClearAllPoints()
	nextext:SetPoint("RIGHT", LootFrameDownButton, "LEFT", -3, 0)
	LootFrameCloseButton:ClearAllPoints()
	LootFrameCloseButton:SetPoint("TOPRIGHT", 0, 0)
	title:ClearAllPoints()
	title:SetPoint("TOP", 0, -10)

	--Apply the border
	if isBeautiful then
		LootFrame:CreateBeautyBorder(cfg.border.size.large)
		LootFrame:SetBeautyBorderTexture(cfg.border.texture)
		LootTargetPortrait:CreateBeautyBorder(cfg.border.size.large)
		LootTargetPortrait:SetBeautyBorderTexture(cfg.border.texture)
		LootTargetPortrait:SetBeautyBorderPadding(2)
	end

	--events so frame works right
	LootPortraitFrame = CreateFrame("Frame")
	LootPortraitFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	LootPortraitFrame:RegisterEvent("LOOT_OPENED")
	LootPortraitFrame:SetScript("OnEvent", function(self, event, id)
		if event == "LOOT_OPENED" then
			if UnitExists("target") then
				LootTargetPortrait:SetUnit("target")
				LootTargetPortrait:SetCamera(0)
			else
				LootTargetPortrait:ClearModel()
				LootTargetPortrait:SetModel("PARTICLES\\Lootfx.m2")
			end
		elseif event == "LOOT_CLOSED" then
			BobLootBackround:Hide()
		end
	end)

	LootFrame:EnableMouse(true)
	LootFrame:SetUserPlaced(true)
	LootFrame:RegisterForDrag("LeftButton")
	LootFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	LootFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
end

--group frames (work in progress)
if cfg.AutoAcceptRolls then
	local f = CreateFrame("Frame")
	f:RegisterEvent("CONFIRM_DISENCHANT_ROLL")
	f:SetScript("OnEvent", function(self, event, id, rollType)
		for i=1,STATICPOPUP_NUMDIALOGS do
			local frame = _G["StaticPopup"..i]
			if frame.which == "CONFIRM_LOOT_ROLL" and frame.data == id and frame.data2 == rollType and frame:IsVisible() then StaticPopup_OnClick(frame, 1) end
		end
	end)
end
]]