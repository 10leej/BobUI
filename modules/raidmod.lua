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
SLASH_COUNTDOWN1 = "/pull"