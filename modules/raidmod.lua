--Simple raid mod that aids a player in raid/group environments (this is not a boss mod!)
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace

--Kill Blizz DBM
if cfg.HideBossEmote then
	RaidBossEmoteFrame:UnregisterAllEvents()
end

--Pull countdown
local pull, seconds, onesec
local frame = CreateFrame("Frame")
frame:Hide()
frame:SetScript("OnUpdate", function(self, elapsed)
	--Start DBM pull timer (not implemented)
	onesec = onesec - elapsed
    pull = pull - elapsed
    if pull <= 0 then
        SendChatMessage("Pulling!", cfg.channelannounce)
        self:Hide()
    elseif onesec <= 0 then
        SendChatMessage(seconds, cfg.channelannounce)
        seconds = seconds - 1
        onesec = 1
    end
end)
SlashCmdList["COUNTDOWN"] = function(t)
    t = tonumber(t) or 6
    pull = t + 1
    seconds = t
    onesec = 1
    frame:Show()
end
SLASH_COUNTDOWN1 = "/inc"


--[[
local PROPOSAL_DURATION = 40

local bar = CreateFrame("StatusBar", nil, LFGDungeonReadyPopup)
bar:SetPoint("TOPLEFT", LFGDungeonReadyPopup, "BOTTOMLEFT", 0, -5)
bar:SetPoint("TOPRIGHT", LFGDungeonReadyPopup, "BOTTOMRIGHT", 0, -5)
bar:SetHeight(5)
bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
bar:SetMinMaxValues(0, PROPOSAL_DURATION)

local spark = bar:CreateTexture(nil, "OVERLAY")
spark:SetPoint("CENTER", bar:GetStatusBarTexture(), "LEFT")
spark:SetSize(5, 8) -- height should be about 2.5x width
spark:SetAlpha(0.5)
spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
spark:SetBlendMode("ADD")

local t = PROPOSAL_DURATION
local HALF_POINT = PROPOSAL_DURATION / 2
bar:SetScript("OnUpdate", function(self, elapsed)
     t = t - elapsed
     self:SetValue(t)
     if t > HALF_POINT then
          self:SetStatusBarColor(1, t / PROPOSAL_DURATION, 0)
     else
          self:SetStatusBarColor(1 - (t / PROPOSAL_DURATION), 1, 0)
     end
end)

frame:RegisterEvent("LFG_PROPOSAL_SHOW")
frame:SetScript("OnEvent", function(self, event)
     if event == "LFG_PROPOSAL_SHOW" then
          t = PROPOSAL_DURATION
          self:Show()
     else
          self:Hide()
     end
end)
]]