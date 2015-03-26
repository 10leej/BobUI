--Very lightweight Actionbar Addon pretty much a modified version of zork's rActionBarStyler rewrote to fit my needs
local _, cfg = ...
local addon, ns = ...

if not cfg.ActionBars then return end --module control
-----------------------------
-- blizzHider
-----------------------------
--hide blizzard
local Bar1enable = true --This addon breaks if this is false
local overridebarenable = true --breaks vehicle bar if false
local blizzHider = CreateFrame("Frame","Bob_BizzardHider")
blizzHider:Hide()
--hide main menu bar frames
if Bar1enable then
	MainMenuBar:SetParent(blizzHider)
	MainMenuBarPageNumber:SetParent(blizzHider)
	ActionBarDownButton:SetParent(blizzHider)
	ActionBarUpButton:SetParent(blizzHider)
end
--hide override actionbar frames
if overridebarenable then
	OverrideActionBarExpBar:SetParent(blizzHider)
	OverrideActionBarHealthBar:SetParent(blizzHider)
	OverrideActionBarPowerBar:SetParent(blizzHider)
	OverrideActionBarPitchFrame:SetParent(blizzHider) --maybe we can use that frame later for pitchig and such
end
-----------------------------
-- HIDE TEXTURES
-----------------------------
--remove some the default background textures
StanceBarLeft:SetTexture(nil)
StanceBarMiddle:SetTexture(nil)
StanceBarRight:SetTexture(nil)
SlidingActionBarTexture0:SetTexture(nil)
SlidingActionBarTexture1:SetTexture(nil)
PossessBackground1:SetTexture(nil)
PossessBackground2:SetTexture(nil)
if Bar1enable then
	MainMenuBarTexture0:SetTexture(nil)
	MainMenuBarTexture1:SetTexture(nil)
	MainMenuBarTexture2:SetTexture(nil)
	MainMenuBarTexture3:SetTexture(nil)
	MainMenuBarLeftEndCap:SetTexture(nil)
	MainMenuBarRightEndCap:SetTexture(nil)
end
--remove OverrideBar textures
if overridebarenable then
	local textureList =  {
	"_BG",
	"EndCapL",
	"EndCapR",
	"_Border",
	"Divider1",
	"Divider2",
	"Divider3",
	"ExitBG",
	"MicroBGL",
	"MicroBGR",
	"_MicroBGMid",
	"ButtonBGL",
	"ButtonBGR",
	"_ButtonBGMid",
	}

	for _,tex in pairs(textureList) do
		OverrideActionBar[tex]:SetAlpha(0)
	end
end

--Cleanup the ExtraActionButton	
-- hook the ExtraActionButton1 texture, idea by roth via WoWInterface forums
-- code taken from Tukui
local button = ExtraActionButton1
local icon = button.icon
local texture = button.style
local disableTexture = function(style, texture)
	-- look like sometime the texture path is set to capital letter instead of lower-case
	if string.sub(texture,1,9) == "Interface" or string.sub(texture,1,9) == "INTERFACE" then
		style:SetTexture("")
	end
end
button.style:SetTexture("")
hooksecurefunc(texture, "SetTexture", disableTexture)
