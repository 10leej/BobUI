--This is an optional standalone addon for BobUI (Bobchat)
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check

if not cfg.Chat then return end --module control

--backdrop function
local function CreateBackdrop(frame) --I call this too much, time for a library I think
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

--Channel names
--guild
CHAT_GUILD_GET = "|Hchannel:GUILD|h[G]|h %s "
CHAT_OFFICER_GET = "|Hchannel:OFFICER|hO|h %s "

--raid
CHAT_RAID_GET = "|Hchannel:RAID|h[R]|h %s "
CHAT_RAID_WARNING_GET = "[RW] %s "
CHAT_RAID_LEADER_GET = "|Hchannel:RAID|h[RL]|h %s "

--party
CHAT_PARTY_GET = "|Hchannel:PARTY|h[P]|h %s "
CHAT_PARTY_LEADER_GET =  "|Hchannel:PARTY|h[PL]|h %s "
CHAT_PARTY_GUIDE_GET =  "|Hchannel:PARTY|h[PG]|h %s "

--bg and instances
CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[I]|h %s: "
CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[IL]|h %s: "

--whisper
CHAT_WHISPER_INFORM_GET = "to %s "
CHAT_WHISPER_GET = "from %s "
CHAT_BN_WHISPER_INFORM_GET = "to %s "
CHAT_BN_WHISPER_GET = "from %s "

--say / yell
CHAT_SAY_GET = "%s "
CHAT_YELL_GET = "%s "

--flags
CHAT_FLAG_AFK = "[AFK] "
CHAT_FLAG_DND = "[DND] "
CHAT_FLAG_GM = "[GM] "

local gsub = _G.string.gsub

for i = 1, NUM_CHAT_WINDOWS do
	if ( i ~= 2 ) then
		local f = _G["ChatFrame"..i]
		local am = f.AddMessage
		f.AddMessage = function(frame, text, ...)
			return am(frame, text:gsub('|h%[(%d+)%. .-%]|h', '|h%1|h'), ...)
		end
    end
end

---------------- > Chat Scroll Module
hooksecurefunc('FloatingChatFrame_OnMouseScroll', function(self, dir)
	if dir > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		elseif IsControlKeyDown() then
			--only need to scroll twice because of blizzards scroll
			self:ScrollUp()
			self:ScrollUp()
		end
	elseif dir < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		elseif IsControlKeyDown() then
			--only need to scroll twice because of blizzards scroll
			self:ScrollDown()
			self:ScrollDown()
		end
	end
end)


---------------- > URL copy
local SetItemRef_orig = SetItemRef;
function ReURL_SetItemRef(link, text, button)
	if (strsub(link, 1, 3) == "url") then
		local url = strsub(link, 5);
		local activeWindow = ChatEdit_GetActiveWindow();
		if ( activeWindow ) then
			activeWindow:Insert(url);
			ChatEdit_FocusActiveWindow();
		else
			ChatEdit_GetLastActiveWindow():Show();
			ChatEdit_GetLastActiveWindow():Insert(url);
			ChatEdit_GetLastActiveWindow():SetFocus();
		end
	else
		SetItemRef_orig(link, text, button);
	end
end
SetItemRef = ReURL_SetItemRef;

function ReURL_AddLinkSyntax(chatstring)
	if (type(chatstring) == "string") then
		local extraspace;
		if (not strfind(chatstring, "^ ")) then
			extraspace = true;
			chatstring = " "..chatstring;
		end
		chatstring = gsub (chatstring, " www%.([_A-Za-z0-9-]+)%.(%S+)%s?", ReURL_Link("www.%1.%2"))
		chatstring = gsub (chatstring, " (%a+)://(%S+)%s?", ReURL_Link("%1://%2"))
		chatstring = gsub (chatstring, " ([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-]+)(%.+)([_A-Za-z0-9-%.]+)%s?", ReURL_Link("%1@%2%3%4"))
		chatstring = gsub (chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?):(%d%d?%d?%d?%d?)%s?", ReURL_Link("%1.%2.%3.%4:%5"))
		chatstring = gsub (chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%s?", ReURL_Link("%1.%2.%3.%4"))
		if (extraspace) then
			chatstring = strsub(chatstring, 2);
		end
	end
	return chatstring
end

REURL_COLOR = "FFFF55";
ReURL_Brackets = nil;
ReUR_CustomColor = true;

function ReURL_Link(url)
	if (ReUR_CustomColor) then
		if (ReURL_Brackets) then
			url = " |cff"..REURL_COLOR.."|Hurl:"..url.."|h["..url.."]|h|r "
		else
			url = " |cff"..REURL_COLOR.."|Hurl:"..url.."|h"..url.."|h|r "
		end
	else
		if (ReURL_Brackets) then
			url = " |Hurl:"..url.."|h["..url.."]|h "
		else
			url = " |Hurl:"..url.."|h"..url.."|h "
		end
	end
	return url
end

---------------- > Hook all the AddMessage funcs
for i=1, NUM_CHAT_WINDOWS do
	local frame = _G["ChatFrame"..i]
	local addmessage = frame.AddMessage
	frame.AddMessage = function(self, text, ...) addmessage(self, ReURL_AddLinkSyntax(text), ...) end
end


---------------- > move chat frames to edge of screen
do
for i=1, NUM_CHAT_WINDOWS
	do local cf = _G[format("%s%d", "ChatFrame", i)]
		cf:SetClampedToScreen(true)
		cf:SetClampRectInsets(0,0,0,0)
	end
end

---------------- > Chat tabs
if cfg.chat.style_chat_tabs then
local Fane = CreateFrame'Frame'
local inherit = GameFontNormalSmall
local updateFS = function(self, inc, flags, ...)
	local fstring = self:GetFontString()
	local font, fontSize = inherit:GetFont()
	if(inc) then
		fstring:SetFont(font, fontSize + 1, flags)
	else
		fstring:SetFont(font, fontSize, flags)
	end
	if((...)) then
		fstring:SetTextColor(...)
	end
end
local OnEnter = function(self)
	local emphasis = _G["ChatFrame"..self:GetID()..'TabFlash']:IsShown()
	updateFS(self, emphasis, 'OUTLINE', .64, .207, .933)
end
local OnLeave = function(self)
	local r, g, b
	local id = self:GetID()
	local emphasis = _G["ChatFrame"..id..'TabFlash']:IsShown()
	if (_G["ChatFrame"..id] == SELECTED_CHAT_FRAME) then
		r, g, b = .64, .207, .933
	elseif emphasis then
		r, g, b = 1, 0, 0
	else
		r, g, b = 1, 1, 1
	end
	updateFS(self, emphasis, nil, r, g, b)
end
local ChatFrame2_SetAlpha = function(self, alpha)
	if(CombatLogQuickButtonFrame_Custom) then
		CombatLogQuickButtonFrame_Custom:SetAlpha(alpha)
	end
end
local ChatFrame2_GetAlpha = function(self)
	if(CombatLogQuickButtonFrame_Custom) then
		return CombatLogQuickButtonFrame_Custom:GetAlpha()
	end
end
local faneifyTab = function(frame, sel)
	local i = frame:GetID()
	if(not frame.Fane) then
		frame.leftTexture:Hide()
		frame.middleTexture:Hide()
		frame.rightTexture:Hide()
		frame.leftSelectedTexture:Hide()
		frame.middleSelectedTexture:Hide()
		frame.rightSelectedTexture:Hide()
		frame.leftSelectedTexture.Show = frame.leftSelectedTexture.Hide
		frame.middleSelectedTexture.Show = frame.middleSelectedTexture.Hide
		frame.rightSelectedTexture.Show = frame.rightSelectedTexture.Hide
		frame.leftHighlightTexture:Hide()
		frame.middleHighlightTexture:Hide()
		frame.rightHighlightTexture:Hide()
		frame:HookScript('OnEnter', OnEnter)
		frame:HookScript('OnLeave', OnLeave)
		frame:SetAlpha(1)
		if(i ~= 2) then
			-- Might not be the best solution, but we avoid hooking into the UIFrameFade
			-- system this way.
			frame.SetAlpha = UIFrameFadeRemoveFrame
		else
			frame.SetAlpha = ChatFrame2_SetAlpha
			frame.GetAlpha = ChatFrame2_GetAlpha
			-- We do this here as people might be using AddonLoader together with Fane.
			if(CombatLogQuickButtonFrame_Custom) then
				CombatLogQuickButtonFrame_Custom:SetAlpha(.4)
			end
		end
		frame.Fane = true
	end
	-- We can't trust sel. :(
	if(i == SELECTED_CHAT_FRAME:GetID()) then
		updateFS(frame, nil, nil, .64, .207, .933)
	else
		updateFS(frame, nil, nil, 1, 1, 1)
	end
end
hooksecurefunc('FCF_StartAlertFlash', function(frame)
	local tab = _G['ChatFrame' .. frame:GetID() .. 'Tab']
	updateFS(tab, true, nil, 1, 0, 0)
end)
hooksecurefunc('FCFTab_UpdateColors', faneifyTab)
for i=1,7 do
	faneifyTab(_G['ChatFrame' .. i .. 'Tab'])
end
function Fane:ADDON_LOADED(event, addon)
	if(addon == 'Blizzard_CombatLog') then
		self:UnregisterEvent(event)
		self[event] = nil
		return CombatLogQuickButtonFrame_Custom:SetAlpha(.4)
	end
end
Fane:RegisterEvent'ADDON_LOADED'
Fane:SetScript('OnEvent', function(self, event, ...)
	return self[event](self, event, ...)
end)
end

---------------- > now to style it
-- helper function to remove elements
local function kill(f) --kill it! kill it with fire!
	if f.UnregisterAllEvents then
		f:UnregisterAllEvents()
	end
	--f.Show = function() end
	f:Hide()
end

do
	-- Buttons Hiding/moving
	--local kill = function(f) f:Hide() end
	ChatFrameMenuButton:Hide()
	ChatFrameMenuButton:SetScript("OnShow", kill)
	--QuickJoinToastButton:Hide()
	ChatFrameChannelButton:Hide()

	for i=1, NUM_CHAT_WINDOWS do
		local cf = _G[format("%s%d", "ChatFrame", i)]
	--fix fading
		cf:SetFading(false)	--Set Chat frame level
		--cf:SetFrameStrata("HIGH") --I'm not sure we actually need this anymore.
		cf:SetFont(cfg.font, cfg.chat.size, cfg.chat.style)
	-- Hide chat textures
		for j = 1, #CHAT_FRAME_TEXTURES do
			_G["ChatFrame"..i..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
		end
	--Unlimited chatframes resizing
		cf:SetMinResize(0,0)
		cf:SetMaxResize(0,0)

	--Allow the chat frame to move to the end of the screen but no further
		cf:SetClampedToScreen(true) --because it bothers me otherwise
		cf:SetClampRectInsets(0,0,0,0)
	--Setup a backround!

	--EditBox Module
		local ebParts = {'Left', 'Mid', 'Right'}
		local eb = _G['ChatFrame'..i..'EditBox']
		for _, ebPart in ipairs(ebParts) do
			_G['ChatFrame'..i..'EditBox'..ebPart]:SetTexture(0, 0, 0, 0)
			local ebed = _G['ChatFrame'..i..'EditBoxFocus'..ebPart]
			--ebed:SetTexture(0,0,0,0)
			--ebed:SetHeight(cfg.ebox.height)
		end
		eb:SetAltArrowKeyMode(false)
		eb:ClearAllPoints()
		eb:SetPoint("BOTTOMLEFT", UIParent, cfg.ebox.point[1], cfg.ebox.point[2], cfg.ebox.point[3])
		eb:SetPoint("BOTTOMRIGHT", UIParent, cfg.ebox.point[1], cfg.ebox.point[2]+cfg.ebox.width, cfg.ebox.point[3])
		eb:EnableMouse(false)
		CreateBackdrop(eb)

	--Remove scroll buttons
		local bf = _G['ChatFrame'..i..'ButtonFrame']
		bf:Hide()
		bf:SetScript("OnShow",  kill)
	end
end

--hide realm names in chat
local a,g = getmetatable(DEFAULT_CHAT_FRAME).__index.AddMessage,gsub
getmetatable(DEFAULT_CHAT_FRAME).__index.AddMessage = function(s,t,...)
	if s == ChatFrame2 then return a(s,t,...) end -- combat log
	return a(s,g(t,"|Hplayer:(.-)|h(.-)|h",function(a,b)
		return "|Hplayer:"..a.."|h"..g(b,"-([^%]:]+)(.*)","%2|r").."|h"
	end),...)
end
