local _, cfg = ... --import config
local addon, ns = ... --get addon namespace

--modified whoaUnitframes
if not cfg.Unitframes then return end --module control

--[[
--Hard disable this shit
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace

if not cfg.UnitFrames then return end--module control

local config = BobUnitFrames.config
local buffList = BobUnitFrames.buffList
local _, class = UnitClass("player")
local classcolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
local color = nil
local h, hMax, hPercent, m, mMax, mPercent = 0

-- aura positioning constants
local AURA_START_X = 0;
local AURA_START_Y = 20;
local AURA_OFFSET_Y = 3
local LARGE_AURA_SIZE = config.largeAuraSize
local SMALL_AURA_SIZE = config.smallAuraSize
local AURA_ROW_WIDTH = 122
local NUM_TOT_AURA_ROWS = 3

---------------------------------------------------
-- DK RUNES
---------------------------------------------------
if class == "DEATHKNIGHT" then
    RuneButtonIndividual1:ClearAllPoints()
    RuneButtonIndividual1:SetPoint("TOPLEFT", PlayerFrameManaBar, "BOTTOMLEFT", -1, -5)
end

---------------------------------------------------
-- CVAR
---------------------------------------------------
-- # new GetCVarBool("statusTextPercentage")
local function showPercent()
    -- # NUMERIC -> false
	-- # PERCENT -> true
	-- # BOTH    -> true
    if GetCVar("statusTextDisplay") == "NUMERIC" then
        return false
    else
	    return true
    end
end

---------------------------------------------------
-- PARTY
---------------------------------------------------
local function whoa_partyMembersChanged()
    local partyMembers = GetNumPartyMembers()
    if not InCombatLockdown() and partyMembers > 0 then
        for i = 1, partyMembers do
            _G["PartyMemberFrame"..i.."HealthBar"]:ClearAllPoints()
            _G["PartyMemberFrame"..i.."HealthBar"]:SetPoint("TOPLEFT", 45, -15)
            _G["PartyMemberFrame"..i.."HealthBar"]:SetHeight(9)
            _G["PartyMemberFrame"..i.."ManaBar"]:ClearAllPoints()
            _G["PartyMemberFrame"..i.."ManaBar"]:SetPoint("TOPLEFT", 45, -24)
            _G["PartyMemberFrame"..i.."ManaBar"]:SetHeight(6)
            color = RAID_CLASS_COLORS[select(2, UnitClass("party"..i))]
            if color then
                _G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarColor(color.r, color.g, color.b)
                _G["PartyMemberFrame"..i.."HealthBar"].lockColor = true
            end
            if config.repositionPartyText then
                _G["PartyMemberFrame"..i.."HealthBarText"]:ClearAllPoints()
                _G["PartyMemberFrame"..i.."HealthBarText"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."HealthBar"], "RIGHT", 0, 0)
                _G["PartyMemberFrame"..i.."ManaBarText"]:ClearAllPoints()
                _G["PartyMemberFrame"..i.."ManaBarText"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."ManaBar"], "RIGHT", 0, 0)
            end    
        end
    end
end

---------------------------------------------------
-- PLAYERFRAME
---------------------------------------------------
local function whoa_playerFrame()
	PlayerFrame:Hide()
end
hooksecurefunc("PlayerFrame_UpdateArt", whoa_playerFrame)
hooksecurefunc("PlayerFrame_SequenceFinished", whoa_playerFrame)

---------------------------------------------------
-- TARGETFRAME
---------------------------------------------------
local function whoa_targetFrame()
    TargetFrame.nameBackground:Hide()
    TargetFrame.deadText:ClearAllPoints()
    TargetFrame.deadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
    TargetFrameTextureFrameName:ClearAllPoints()
    TargetFrameTextureFrameName:SetPoint("BOTTOMRIGHT", TargetFrame, "TOP", 0, -20)
	TargetFrameBackground:ClearAllPoints()
	TargetFrameBackground:SetPoint("TOPLEFT",TargetFrameHealthBar,"TOPLEFT",0,0)
	TargetFrameBackground:SetSize(119,50)
    TargetFrameHealthBar:ClearAllPoints()
    TargetFrameHealthBar:SetPoint("TOPLEFT", 1, -12)
    TargetFrameHealthBar:SetHeight(28)
	TargetFrameHealthBar:SetStatusBarTexture(cfg.statusbar_texture)
    TargetFrameTextureFrameHealthBarText:ClearAllPoints()
    TargetFrameTextureFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)
    TargetFrameManaBar:ClearAllPoints()
    TargetFrameManaBar:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", 0, -6)
    TargetFrameManaBar:SetHeight(16)
	TargetFrameManaBar:SetStatusBarTexture(cfg.statusbar_texture)
    TargetFrameTextureFrameManaBarText:ClearAllPoints()
    TargetFrameTextureFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, 0)
	TargetFrame.threatNumericIndicator:SetWidth(0.01)
end

local function whoa_targetChanged()
    TargetFrame.nameBackground:Hide()
    TargetFrame.deadText:Hide()
    if UnitIsPlayer("target") and config.classColorTarget then
        color = RAID_CLASS_COLORS[select(2, UnitClass("target"))]
    else
        color = FACTION_BAR_COLORS[UnitReaction("target", "player")]
    end
    if ( not UnitPlayerControlled("target") and UnitIsTapped("target") and not UnitIsTappedByPlayer("target") and not UnitIsTappedByAllThreatList("target") ) then
        TargetFrameHealthBar:SetStatusBarColor(0.5, 0.5, 0.5)
    else
        if color then
            TargetFrameHealthBar:SetStatusBarColor(color.r, color.g, color.b)
            TargetFrameHealthBar.lockColor = true
        end
    end
end
hooksecurefunc("TargetFrame_CheckFaction", whoa_targetChanged)

---------------------------------------------------
-- FOCUSFRAME
---------------------------------------------------
local function whoa_focusFrame()
    FocusFrame.nameBackground:Hide()
	if cfg.HidePortraits then
		FocusFramePortrait:Hide()
	end
    FocusFrame.deadText:ClearAllPoints()
    FocusFrame.deadText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
    FocusFrameTextureFrameName:ClearAllPoints()
	FocusFrameTextureFrameName:SetPoint("BOTTOMRIGHT", TargetFrame, "TOP", 0, -20)
	FocusFrameBackground:ClearAllPoints()
	FocusFrameBackground:SetPoint("TOPLEFT",FocusFrameHealthBar,"TOPLEFT",0,0)
	FocusFrameBackground:SetSize(119,50)
    FocusFrameHealthBar:ClearAllPoints()
	FocusFrameHealthBar:SetPoint("TOPLEFT", 1, -14)
    FocusFrameHealthBar:SetHeight(25)
	FocusFrameHealthBar:SetStatusBarTexture(cfg.statusbar_texture)
    FocusFrameManaBar:ClearAllPoints()
	FocusFrameManaBar:SetPoint("TOP",FocusFrameHealthBar,"BOTTOM", 0, -6)
	FocusFrameManaBar:SetHeight(17)
	FocusFrameManaBar:SetStatusBarTexture(cfg.statusbar_texture)
    FocusFrame.threatNumericIndicator:SetWidth(0.01)
    FocusFrame.threatNumericIndicator.bg:Hide()
    FocusFrame.threatNumericIndicator.text:Hide()
    FocusFrameTextureFrameHealthBarText:ClearAllPoints()
    FocusFrameTextureFrameHealthBarText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)
    FocusFrameTextureFrameManaBarText:ClearAllPoints()
    FocusFrameTextureFrameManaBarText:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0)
end

local function whoa_focusChanged()
    FocusFrame.nameBackground:Hide()
    FocusFrame.deadText:Hide()
    if UnitIsPlayer("focus") and config.classColorFocus then
        color = RAID_CLASS_COLORS[select(2, UnitClass("focus"))]
    else
        color = FACTION_BAR_COLORS[UnitReaction("focus", "player")]
    end
    if color then
        FocusFrameHealthBar:SetStatusBarColor(color.r, color.g, color.b)
        FocusFrameHealthBar.lockColor = true
    end
end

---------------------------------------------------
-- TARGETOFTARGETFRAME
---------------------------------------------------
local function whoa_totFrame()
    -- # TargetOfTarget
	TargetFrameToT.name:SetWidth(0.01)
    TargetFrameToT.name:SetPoint("TOP", TargetFrameToTHealthBar, "BOTTOM", 0, 0)
	TargetFrameToT:ClearAllPoints()
    TargetFrameToT:SetPoint("BOTTOM",TargetFrame,13,-30)
    TargetFrameToTHealthBar:ClearAllPoints()
    TargetFrameToTHealthBar:SetPoint("TOPLEFT", 44, -5)
	TargetFrameToTHealthBar:SetHeight(21)
    TargetFrameToTHealthBar:SetStatusBarTexture(cfg.statusbar_texture)
	TargetFrameToTManaBar:ClearAllPoints()
    TargetFrameToTManaBar:SetPoint("TOP", TargetFrameToTHealthBar, "BOTTOM", 0, -4)
	TargetFrameToTManaBar:SetHeight(10)
    TargetFrameToTManaBar:SetStatusBarTexture(cfg.statusbar_texture)
	TargetFrameToTBackground:SetSize(50,35)
	TargetFrameToTBackground:ClearAllPoints()
	TargetFrameToTBackground:SetPoint("TOP",TargetFrameToTHealthBar,0,0)
	-- # TargetOfFocus
	FocusFrameToT.name:SetWidth(0.01)
    FocusFrameToT.name:SetPoint("TOP", FocusFrameToTHealthBar, "BOTTOM", 0, 0)
	FocusFrameToT:ClearAllPoints()
    FocusFrameToT:SetPoint("BOTTOM",FocusFrame,13,-30)
    FocusFrameToTHealthBar:ClearAllPoints()
    FocusFrameToTHealthBar:SetPoint("TOPLEFT", 44, -5)
	FocusFrameToTHealthBar:SetHeight(21)
    FocusFrameToTHealthBar:SetStatusBarTexture(cfg.statusbar_texture)
	FocusFrameToTManaBar:ClearAllPoints()
    FocusFrameToTManaBar:SetPoint("TOP", FocusFrameToTHealthBar, "BOTTOM", 0, -4)
	FocusFrameToTManaBar:SetHeight(10)
    FocusFrameToTManaBar:SetStatusBarTexture(cfg.statusbar_texture)
	FocusFrameToTBackground:SetSize(50,35)
	FocusFrameToTBackground:ClearAllPoints()
	FocusFrameToTBackground:SetPoint("TOP",FocusFrameToTHealthBar,0,0)
end

---------------------------------------------------
-- TEXTE
---------------------------------------------------
local function whoa_createFrame(name, parent, point, xOffset, yOffset, width, alignment)
    local f = CreateFrame("Frame", name, parent)
    f:SetPoint(point, parent, point, xOffset, yOffset)
    f:SetWidth(width)
    f:SetHeight(20)
    f.text = f:CreateFontString(name.."text", "OVERLAY")
    f.text:SetAllPoints(f)
    f.text:SetFontObject(TextStatusBarText)
    f.text:SetJustifyH(alignment)
end

whoa_createFrame("fplayerdead",        PlayerFrameHealthBar, "CENTER",  0, 0, 200, "CENTER")
whoa_createFrame("fplayerpercent",     PlayerFrameHealthBar, "LEFT",    0, 0,  40, "RIGHT")
whoa_createFrame("fplayerhealth",      PlayerFrameHealthBar, "RIGHT",  -5, 0,  75, "RIGHT")
whoa_createFrame("fplayermanapercent", PlayerFrameManaBar,   "LEFT",    0, 0,  40, "RIGHT")
whoa_createFrame("fplayermana",        PlayerFrameManaBar,   "RIGHT",  -5, 0,  75, "RIGHT")

whoa_createFrame("ftargetdead",        TargetFrameHealthBar, "CENTER",  0, 0, 200, "CENTER")
whoa_createFrame("ftargetoffline",     TargetFrameManaBar,   "CENTER",  0, 0, 200, "CENTER")
whoa_createFrame("ftargetpercent",     TargetFrameHealthBar, "LEFT",    0, 0,  40, "RIGHT")
whoa_createFrame("ftargethealth",      TargetFrameHealthBar, "RIGHT",  -5, 0,  75, "RIGHT")
whoa_createFrame("ftargetmanapercent", TargetFrameManaBar,   "LEFT",    0, 0,  40, "RIGHT")
whoa_createFrame("ftargetmana",        TargetFrameManaBar,   "RIGHT",  -5, 0,  75, "RIGHT")

whoa_createFrame("ffocusdead",         FocusFrameHealthBar,  "CENTER",  0, 0, 200, "CENTER")
whoa_createFrame("ffocusoffline",      FocusFrameManaBar,    "CENTER",  0, 0, 200, "CENTER")
whoa_createFrame("ffocuspercent",      FocusFrameHealthBar,  "LEFT",  	5, 0,  40, "LEFT")
whoa_createFrame("ffocushealth",       FocusFrameHealthBar,  "RIGHT",  -5, 0,  75, "RIGHT")
whoa_createFrame("ffocusmanapercent",  FocusFrameManaBar,    "LEFT",  	5, 0,  40, "LEFT")
whoa_createFrame("ffocusmana",         FocusFrameManaBar,    "RIGHT",  -5, 0,  75, "RIGHT")

ftargetoffline.text:SetText(config.phrases["Offline"])
ffocusoffline.text:SetText(config.phrases["Offline"])

local function whoa_round(n, dp)
    return math.floor((n * 10^dp) + .5) / (10^dp)
end

local function whoa_format(n)
    if not config.customStatusText then
        return n
    end
    local strLen = strlen(n)
--  if config.simpleHealth and n > 999999999 then
    if config.simpleHealth and strLen > 9 then
        return whoa_round(n/1e9, 1)..config.phrases["giga"]
--  elseif config.simpleHealth and n > 999999 then
    elseif config.simpleHealth and strLen > 6 then
        return whoa_round(n/1e6, 1)..config.phrases["mega"]
--  elseif config.simpleHealth and strLen > 5 then -- no simpleHealth under 100.000
    elseif config.simpleHealth and n > 199999 then -- no simpleHealth under 199.999
        return whoa_round(n/1e3, 0)..config.phrases["kilo"]
    elseif config.thousandSeparators then
        local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)')
        return left..(num:reverse():gsub('(%d%d%d)', '%1'..config.phrases["1000 separator"]):reverse())..right
    else
        return n
    end
end

local function whoa_unitText(unit)
    if config.customStatusText and (unit == "player" or unit == "target" or unit == "focus") then
        h = UnitHealth(unit)
        if UnitIsDeadOrGhost(unit) then
            _G["f"..unit.."health"]:Hide()
            _G["f"..unit.."percent"]:Hide()
            _G["f"..unit.."dead"]:Show()
            if UnitIsGhost(unit) then
                _G["f"..unit.."dead"].text:SetText(config.phrases["Ghost"])
            else
                _G["f"..unit.."dead"].text:SetText(config.phrases["Dead"])
            end
        else
            _G["f"..unit.."dead"]:Hide()
            if (unit == "player" and GetCVarBool("playerStatusText"))
            or (not (unit == "player") and GetCVarBool("targetStatusText"))
            then
                _G["f"..unit.."health"]:Show()
                _G["f"..unit.."health"].text:SetText(whoa_format(h))
                if showPercent() then
                    hMax = UnitHealthMax(unit)
                    if hMax > 0 then
                        hPercent = math.floor((h / hMax) * 100)
                        _G["f"..unit.."percent"]:Show()
                        _G["f"..unit.."percent"].text:SetText(hPercent.."%")
                    end
                else
                    _G["f"..unit.."percent"]:Hide()
                end
            else
                _G["f"..unit.."health"]:Hide()
                _G["f"..unit.."percent"]:Hide()
            end
        end
        m = UnitPower(unit)
        if m > 0 then
            if UnitIsDeadOrGhost(unit) then
                _G["f"..unit.."mana"]:Hide()
                _G["f"..unit.."manapercent"]:Hide()
            elseif (unit == "player" and GetCVarBool("playerStatusText"))
                or (not (unit == "player") and GetCVarBool("targetStatusText"))
            then
                _G["f"..unit.."mana"]:Show()
                _G["f"..unit.."mana"].text:SetText(whoa_format(m))
                local showManaPercent = false
                if config.autoManaPercent then
                    if UnitPowerType(unit) == 0 then
                        showManaPercent = true
                    end
                end
                if showPercent() and showManaPercent then
                    mMax = UnitPowerMax(unit)
                    if mMax > 0 then
                        mPercent = math.floor((m / mMax) * 100)
                        _G["f"..unit.."manapercent"]:Show()
                        _G["f"..unit.."manapercent"].text:SetText(mPercent.."%")
                    end
                else
                    _G["f"..unit.."manapercent"]:Hide()
                end
            else
                _G["f"..unit.."mana"]:Hide()
                _G["f"..unit.."manapercent"]:Hide()
            end
        else
            _G["f"..unit.."mana"]:Hide()
            _G["f"..unit.."manapercent"]:Hide()
        end
        if unit == "target" or unit == "focus" then
            if UnitIsConnected(unit) then
                _G["f"..unit.."offline"]:Hide()
            else
                _G["f"..unit.."offline"]:Show()
                _G["f"..unit.."mana"]:Hide()
                _G["f"..unit.."manapercent"]:Hide()
            end
        end
    end
end

---------------------------------------------------
-- TARGETBUFFS
---------------------------------------------------
local function whoa_targetUpdateAuraPositions(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
    local size
    local offsetY = AURA_OFFSET_Y
    local rowWidth = 0
    local firstBuffOnRow = 1
    for i=1, numAuras do
        if ( largeAuraList[i] ) then
            size = LARGE_AURA_SIZE
            offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y
        else
            size = SMALL_AURA_SIZE
        end
        if ( i == 1 ) then
            rowWidth = size
            self.auraRows = self.auraRows + 1
        else
            rowWidth = rowWidth + size + offsetX
        end
        if ( rowWidth > maxRowWidth ) then
            updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)
            rowWidth = size
            self.auraRows = self.auraRows + 1
            firstBuffOnRow = i
            offsetY = AURA_OFFSET_Y
        else
            updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
        end
    end
end
hooksecurefunc("TargetFrame_UpdateAuraPositions", whoa_targetUpdateAuraPositions)

local function whoa_targetUpdateBuffAnchor(self, buffName, index, numDebuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
    local point, relativePoint
    local startY, auraOffsetY
    if ( mirrorVertically ) then
        point = "BOTTOM"
        relativePoint = "TOP"
        startY = -8
        offsetY = -offsetY
        auraOffsetY = -AURA_OFFSET_Y
    else
        point = "TOP"
        relativePoint="BOTTOM"
        startY = AURA_START_Y
        auraOffsetY = AURA_OFFSET_Y
    end
     
    local buff = _G[buffName..index]
    if ( index == 1 ) then
        if ( UnitIsFriend("player", self.unit) or numDebuffs == 0 ) then
		    -- unit is friendly or there are no debuffs...buffs start on top
            buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY)           
        else
		    -- unit is not friendly and we have debuffs...buffs start on bottom
            buff:SetPoint(point.."LEFT", self.debuffs, relativePoint.."LEFT", 0, -offsetY)
        end
        self.buffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0)
        self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY)
        self.spellbarAnchor = buff
    elseif ( anchorIndex ~= (index-1) ) then
	    -- anchor index is not the previous index...must be a new row
        buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY)
        self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY)
        self.spellbarAnchor = buff
    else
	    -- anchor index is the previous index
        buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], point.."RIGHT", offsetX, 0)
    end

    buff:SetWidth(size)
    buff:SetHeight(size)
end
hooksecurefunc("TargetFrame_UpdateBuffAnchor", whoa_targetUpdateBuffAnchor)

function whoa_targetUpdateDebuffAnchor(self, debuffName, index, numBuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
    local buff = _G[debuffName..index];
    local isFriend = UnitIsFriend("player", self.unit);
     
    --For mirroring vertically
    local point, relativePoint;
    local startY, auraOffsetY;
    if ( mirrorVertically ) then
        point = "BOTTOM";
        relativePoint = "TOP";
        startY = -8;
        offsetY = - offsetY;
        auraOffsetY = -AURA_OFFSET_Y;
    else
        point = "TOP";
        relativePoint="BOTTOM";
        startY = AURA_START_Y;
        auraOffsetY = AURA_OFFSET_Y;
    end
     
    if ( index == 1 ) then
        if ( isFriend and numBuffs > 0 ) then
            -- unit is friendly and there are buffs...debuffs start on bottom
            buff:SetPoint(point.."LEFT", self.buffs, relativePoint.."LEFT", 0, -offsetY);
        else
            -- unit is not friendly or there are no buffs...debuffs start on top
            buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
        end
        self.debuffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0);
        self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
        if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
            self.spellbarAnchor = buff;
        end
    elseif ( anchorIndex ~= (index-1) ) then
        -- anchor index is not the previous index...must be a new row
        buff:SetPoint(point.."LEFT", _G[debuffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY);
        self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
        if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
            self.spellbarAnchor = buff;
        end
    else
        -- anchor index is the previous index
        buff:SetPoint(point.."LEFT", _G[debuffName..(index-1)], point.."RIGHT", offsetX, 0);
    end
 
    -- Resize
    buff:SetWidth(size);
    buff:SetHeight(size);
    if cfg.SkinUI then
		buff:CreateBorder(8,1,1,1)
	end
	local debuffFrame =_G[debuffName..index.."Border"];
    debuffFrame:SetWidth(size+2);
    debuffFrame:SetHeight(size+2);
    if cfg.SkinUI then
		debuffFrame:CreateBorder(8,1,1,1)
	end
end
hooksecurefunc("TargetFrame_UpdateDebuffAnchor", whoa_targetUpdateDebuffAnchor)

---------------------------------------------------
-- CVAR_UPDATES
---------------------------------------------------
if config.customStatusText then
    function PlayerFrameHealthBarText:Show() end
    function PlayerFrameManaBarText:Show() end
    function TargetFrameTextureFrameHealthBarText:Show() end
    function TargetFrameTextureFrameManaBarText:Show() end
    function FocusFrameTextureFrameHealthBarText:Show() end
    function FocusFrameTextureFrameManaBarText:Show() end
    PlayerFrameHealthBarText:Hide()
    PlayerFrameManaBarText:Hide()
    TargetFrameTextureFrameHealthBarText:Hide()
    TargetFrameTextureFrameManaBarText:Hide()
    FocusFrameTextureFrameHealthBarText:Hide()
    FocusFrameTextureFrameManaBarText:Hide()
end

local function whoa_cvarUpdate()
    if GetCVarBool("fullSizeFocusFrame") then
        FocusFrameTextureFrameName:SetPoint("BOTTOMRIGHT", FocusFrame, "TOP", 0, -20)
    else
        FocusFrameTextureFrameName:SetPoint("BOTTOMRIGHT", FocusFrame, "TOP", 10, -20)
    end
    whoa_unitText("player")
    whoa_unitText("target")
    whoa_unitText("focus")
end

---------------------------------------------------
-- EVENTS
---------------------------------------------------
local w = CreateFrame("Frame")
w:RegisterEvent("PLAYER_ENTERING_WORLD")
w:RegisterEvent("PLAYER_REGEN_ENABLED")
w:RegisterEvent("PLAYER_TARGET_CHANGED")
w:RegisterEvent("PLAYER_FOCUS_CHANGED")
w:RegisterEvent("FOCUS_TARGET_CHANGED")
w:RegisterEvent("UNIT_PET")
w:RegisterEvent("CVAR_UPDATE")
w:RegisterEvent("GROUP_ROSTER_UPDATE")
w:RegisterEvent("UNIT_FACTION")
w:RegisterEvent("UNIT_HEALTH")
w:RegisterEvent("UNIT_POWER")
w:RegisterUnitEvent("UNIT_PET", "player")
if config.classColorParty then
    w:RegisterEvent("PARTY_MEMBERS_CHANGED")
end
function w:OnEvent(event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        SlashCmdList['RELOAD'] = function() ReloadUI() end
        SLASH_RELOAD1 = '/rl'
        whoa_playerFrame()
        whoa_targetFrame()
        whoa_focusFrame()
        whoa_totFrame()
        whoa_cvarUpdate()
        whoa_unitText("player")
    elseif event == "PLAYER_REGEN_ENABLED" then
        whoa_playerFrame()
    elseif event == "PLAYER_TARGET_CHANGED" then
        whoa_targetChanged()
		whoa_unitText("target")
		TargetFrameTextureFrameTexture:SetTexture("Interface\\Addons\\BobMiniUI\\media\\unitframes\\unitframe")
		TargetFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\BobMiniUI\\media\\unitframes\\ToT")
    elseif event == "PLAYER_FOCUS_CHANGED" then
        whoa_focusChanged()
        whoa_unitText("focus")
		FocusFrameTextureFrameTexture:SetTexture("Interface\\Addons\\BobMiniUI\\media\\unitframes\\unitframe")
	elseif event == "FOCUS_TARGET_CHANGED" then
		FocusFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\BobMiniUI\\media\\unitframes\\ToT")
	elseif event == "UNIT_FACTION" then
		if arg1 == "focus" then
			whoa_focusChanged()
		end
	elseif event == "GROUP_ROSTER_UPDATE" then
		whoa_focusChanged()
    elseif event == "UNIT_HEALTH" or event == "UNIT_POWER" then
        local unit = ...
        whoa_unitText(unit)
    elseif event == "CVAR_UPDATE" then
        whoa_cvarUpdate()
    elseif event == "PARTY_MEMBERS_CHANGED" then
        whoa_partyMembersChanged()
	end
end
w:SetScript("OnEvent", w.OnEvent)

--Hiding general stuffs here so out unitframe look better at all times
--Register Events
local noop = function() return end
	
for _, objname in ipairs({
	"PlayerAttackBackground",
	"PlayerAttackGlow",
	"PlayerFrameFlash",
	"PlayerHitIndicator",
	"PlayerRestGlow",
	"PlayerStatusGlow",
	"PlayerStatusTexture",
		
	"TargetFrameFlash",
	"TargetFrameNameBackground",

	"FocusFrameFlash",
	"FocusFrameNameBackground",
	"FocusFrameToTTextureFrame",

	"PetAttackModeTexture",
	"PetFrameFlash",
	"PetHitIndicator",
	
	"ComboPoint1",
	"ComboPoint2",
	"ComboPoint3",
	"ComboPoint4",
	"ComboPoint5",
}) do
	local obj = _G[objname]
	if obj then
		obj:Hide()
		obj.Show = noop
	end
end

--Class Icon portraits
hooksecurefunc("UnitFramePortrait_Update",function(self)
	if self.portrait then
		if UnitIsPlayer(self.unit) then
			local t = CLASS_ICON_TCOORDS[select(2,UnitClass(self.unit))]
			if t then
				self.portrait:SetTexture("Interface\\WorldStateFrame\\ICONS-CLASSES")
				self.portrait:SetTexCoord(unpack(t))
			end
		else
			self.portrait:SetTexCoord(0,1,0,1)
		end
	end
end);
]]