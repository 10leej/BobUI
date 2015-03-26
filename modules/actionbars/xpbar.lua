--XP bar
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check

if not cfg.ActionBars then return end--module control
------------[[XP Bar]]------------
if cfg.xp.enable then
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
	
	local classColor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
	local _G = getfenv(0)

	local xpbar = CreateFrame("Frame", "BobXP", UIParent)
	xpbar:SetPoint(unpack(cfg.xp.position))
	xpbar:SetWidth(cfg.xp.width)
	xpbar:SetHeight(cfg.xp.height)
	
	CreateBackdrop(xpbar)

	local font = CreateFont("BobXPFont")
	font:SetFontObject(GameFontHighlightSmall)
	font:SetTextColor(classColor.r, classColor.g, classColor.b)

	local indictator = xpbar:CreateTexture(nil, "OVERLAY")
	indictator:SetWidth(1)
	indictator:SetTexture(classColor.r, classColor.g, classColor.b)
	indictator:SetHeight(cfg.xp.height)

	local textMain = xpbar:CreateFontString(nil, "OVERLAY")
	textMain:SetPoint("LEFT", indictator, "RIGHT", 10, -2)
	textMain:SetFontObject(font)

	local textTR = xpbar:CreateFontString(nil, "OVERLAY")
	textTR:SetPoint("BOTTOMRIGHT", xpbar, "TOPRIGHT", 0, 2)
	textTR:SetFontObject(font)

	local textTL = xpbar:CreateFontString(nil, "OVERLAY")
	textTL:SetPoint("BOTTOMLEFT", xpbar, "TOPLEFT", 0, 2)
	textTL:SetFontObject(font)

	local textBR = xpbar:CreateFontString(nil, "OVERLAY")
	textBR:SetPoint("TOPRIGHT", xpbar, "BOTTOMRIGHT", 0, -2)
	textBR:SetFontObject(font)

	local textBL = xpbar:CreateFontString(nil, "OVERLAY")
	textBL:SetPoint("TOPLEFT", xpbar, "BOTTOMLEFT", 0, -2)
	textBL:SetFontObject(font)


	--Helper Functions
	function xpbar:Move(ind, perc)
		ind:ClearAllPoints()
		ind:SetPoint("TOPLEFT", cfg.xp.width * perc, 2)
	end

	local function truncate(value)
		if(value > 999 or value < -999) then
			return string.format("|cffffffff%.0f|r k", value / 1e3)
		else
			return "|cffffffff"..value.."|r"
		end
	end

	--Update Functions for xp bar
	function xpbar:PLAYER_ENTERING_WORLD()
		if UnitLevel('player') == MAX_PLAYER_LEVEL then
			self:UPDATE_FACTION()
		else
			self:PLAYER_XP_UPDATE()
		end
	end

	function xpbar:PLAYER_XP_UPDATE()
		local min = UnitXP("player")
		local max = UnitXPMax("player")
		local rested =  GetXPExhaustion()

		textMain:SetFormattedText("|cffffffff%.1f|r%%", min/max*100)
		textTL:SetFormattedText("%s", truncate(min))
		textTR:SetFormattedText("%s", truncate(min-max))
		textBL:SetFormattedText("|cffffffff%.1f|r bars", min/max*20)
		textBR:SetFormattedText("|cffffffff%.1f|r bars", min/max*20-20)

		self:Move(indictator, min/max)
	end
	xpbar.PLAYER_LEVEL_UP = xpbar.PLAYER_XP_UPDATE

	function xpbar:UPDATE_FACTION()
	if UnitLevel('player') == MAX_PLAYER_LEVEL then
			local name, standing, min, max, value = GetWatchedFactionInfo()

			if(not name) then return nil end
			max, min = (max-min), (value-min)

			textMain:SetFormattedText("|cffffffff%.1f|r%%", min/max*100)
			textTL:SetFormattedText("|cffffffff%s|r (|cffffffff%s|r)", name, _G['FACTION_STANDING_LABEL'..standing])
			textTR:SetFormattedText("|cffffffff%s|r / |cffffffff%s|r", min, max)
			textBL:SetFormattedText("")
			textBR:SetFormattedText("")
			self:Move(indictator, min/max)
		end	
	end
	--RegisterEvents
	xpbar:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...)
	end)
	xpbar:RegisterEvent("PLAYER_XP_UPDATE")
	xpbar:RegisterEvent('UPDATE_FACTION')
	xpbar:RegisterEvent("PLAYER_LEVEL_UP")
	xpbar:RegisterEvent("PLAYER_ENTERING_WORLD")
end