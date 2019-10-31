--Bob Minimap, modification of Quilight's qMinimap
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check

if not cfg.Minimap then return end --module control
Minimap:ClearAllPoints()
Minimap:SetPoint(unpack(cfg.minimap.position))
Minimap:SetSize(cfg.minimap.width, cfg.minimap.height)

local dummy = function() end
local _G = getfenv(0)
-----------------------------------------------
--Setting up the buttons
-----------------------------------------------
-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()
-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
-- Hide Toggle Button
MinimapToggleButton:Hide()
-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)
-- Hide Zone Frame
MinimapZoneTextButton:Hide()
-- Hide Calendar Button
GameTimeFrame:Hide()
MinimapCluster:EnableMouse(false)
-- Hide world map button
MiniMapWorldMapButton:Hide()
--Mail Icon
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, 0, 0)
MiniMapMailFrame:SetFrameStrata("LOW")
MiniMapMailBorder:Hide()
-- Set Square Map Mask
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')
--Hide the blob ring
--Minimap:SetArchBlobRingScalar(0)
--Minimap:SetQuestBlobRingScalar(0)

--Create minimap border
if isBeautiful then
	Minimap:CreateBeautyBorder(cfg.border.size.large)
	Minimap:SetBeautyBorderPadding(1)
	Minimap:SetBeautyBorderTexture(cfg.BorderTexture)
end

--Clock
if cfg.Clock then
--Cause we care about class colors?
local playerColor = RAID_CLASS_COLORS[select(2, UnitClass('player'))]
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end
local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont(cfg.font, cfg.time.fontsize, cfg.style)
clockTime:SetTextColor(playerColor.r, playerColor.g, playerColor.b)
TimeManagerClockButton:SetPoint(unpack(cfg.time.position))
clockTime:Show()
end

-- Zone text
if cfg.ZoneText then
	local zoneTextFrame = CreateFrame("Frame", nil, UIParent)
	zoneTextFrame:SetPoint(unpack(cfg.zone.position))
	zoneTextFrame:SetSize(100,cfg.zone.fontsize)
	MinimapZoneText:SetParent(zoneTextFrame)
	MinimapZoneText:ClearAllPoints()
	MinimapZoneText:SetPoint(unpack(cfg.zone.position))
	MinimapZoneText:SetJustifyH(cfg.zone.justify)
	MinimapZoneText:SetFont(cfg.font, cfg.zone.fontsize, cfg.style)
end

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)
