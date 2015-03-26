--Bob Minimap, modification of Quilight's qMinimap
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check

if not cfg.Minimap then return end --module control
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
-- Hide Voice Chat Frame
MiniMapVoiceChatFrame:Hide()
-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)
-- Hide Zone Frame
MinimapZoneTextButton:Hide()
-- Hide Calendar Button
GameTimeFrame:Hide()
MinimapCluster:EnableMouse(false)
--Tracking Button
MiniMapTrackingBackground:SetAlpha(0)
MiniMapTrackingButton:SetAlpha(0)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("BOTTOMRIGHT", Minimap, 0, 0)
MiniMapTracking:SetScale(1)
-- Hide world map button
MiniMapWorldMapButton:Hide()
-- Reposition lfg icon at bottom-left
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 2, 1)
QueueStatusMinimapButtonBorder:Hide()
--Mail Icon
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, 0, 0)
MiniMapMailFrame:SetFrameStrata("LOW")
MiniMapMailIcon:SetTexture("Interface\\AddOns\\BobUI\\media\\mail.tga")
MiniMapMailBorder:Hide()
---Hide Instance Difficulty flag
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:Hide()
--disable the hidden world map button
WorldMapPlayerUpper:EnableMouse(false)
WorldMapPlayerLower:EnableMouse(false)

--move garrison button to a more appropriate place
GarrisonLandingPageMinimapButton:ClearAllPoints()
GarrisonLandingPageMinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
GarrisonLandingPageMinimapButton:SetSize(40,40)


-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')
function GetMinimapShape() return "SQUARE" end
--Hide the blob ring
Minimap:SetArchBlobRingScalar(0)
Minimap:SetQuestBlobRingScalar(0)

--Skin the Minimap
CreateBackdrop(Minimap) --with a backdrop!

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

--Watch Frame
if cfg.WatchFrame then
local wf = ObjectiveTrackerFrame
--[[ disabled temporarily, I really hate the look of the button
    WatchFrameCollapseExpandButton:ClearAllPoints()
    WatchFrameCollapseExpandButton.ClearAllPoints = function() end
    WatchFrameCollapseExpandButton:SetPoint("BOTTOMLEFT", Minimap, 0,0)
    WatchFrameCollapseExpandButton:SetAlpha(0)
    WatchFrameCollapseExpandButton:SetFrameStrata("MEDIUM")
    WatchFrameCollapseExpandButton:SetFrameLevel(2)
]]
    wf:ClearAllPoints()
    wf.ClearAllPoints = function() end
    wf:SetPoint(unpack(cfg.wf.position)) 
    wf.SetPoint = function() end
    wf:SetHeight(cfg.wf.height)

--auto collaps objective tracker depending on situation
if cfg.wf.autocollapse then
  local wfboss = CreateFrame("Frame", nil)
    wfboss:RegisterEvent("PLAYER_ENTERING_WORLD")
    wfboss:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
    wfboss:RegisterEvent("UNIT_TARGETABLE_CHANGED")
    wfboss:RegisterEvent("PLAYER_REGEN_ENABLED")
    wfboss:RegisterEvent("UPDATE_WORLD_STATES")

    local function bossexists()
	for i = 1, MAX_BOSS_FRAMES do
	    if UnitExists("boss"..i) then
	        return true
	    end
	end
    end

    wfboss:SetScript("OnEvent", function(self, event)
    local _, instanceType = IsInInstance()
    local bar = _G["WorldStateCaptureBar1"]
    local mapcheck = GetMapInfo(mapFileName)

    -- collapse if there's a boss
    if bossexists() then
	if not wf.collapsed then
	    ObjectiveTracker_Collapse()
	end
	-- or we're pvping
	elseif instanceType=="arena" or instanceType=="pvp" then
	    if not wf.collapsed then
	        ObjectiveTracker_Collapse()
	    end
	-- or if we get a tracker bar appear.
	elseif bar and bar:IsVisible() then
	    if not wf.collapsed then
	        ObjectiveTracker_Collapse()
	    end
	-- open back up afterward if we're in a raid 
	elseif wf.collapsed and instanceType=="raid" and not InCombatLockdown() then
	        ObjectiveTracker_Expand()
	-- or in Ashran.
	-- add other maps here at some point? Wintergrasp etc. might be needed
	elseif wf.collapsed and mapcheck=="Ashran" and not InCombatLockdown() then
	    ObjectiveTracker_Expand()
	end
    end)
end
end
--World map enhancements
if cfg.WorldMap.makeMovable then
    SetCVar("lockedWorldMap", 0) --make the world map draggable
end
--[[make map transparent when moving
if cfg.WorldMap.fadeMapOnMove then
    local f=CreateFrame("Frame",nil,WorldMapFrame)
    local timer = 0
    f:SetScript("OnUpdate",function(self,elapsed)
    timer = timer + elapsed
    if timer > 0.25 then
        timer = 0
        local still = GetUnitSpeed("player")==0
        WorldMapFrame:SetAlpha(still and 1 or cfg.WorldMap.fadeAlpha)
            for i=1,18 do
                _G["WorldMapFrameTexture"..i]:SetAlpha(still and 1 or 0)
            end
        end
    end)
end
]]