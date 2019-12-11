--Very lightweight Actionbar Addon pretty much a modified version of zork's rActionBarStyler rewrote to fit my needs
local _, cfg = ...
local addon, ns = ...

-----------------------------
-- blizzHider
-----------------------------
--hide blizzard
local blizzHider = CreateFrame("Frame","Bob_BizzardHider")
blizzHider:Hide()
--hide main menu bar frames
MainMenuBar:SetParent(blizzHider)
MainMenuBarPageNumber:SetParent(blizzHider)
ActionBarDownButton:SetParent(blizzHider)
ActionBarUpButton:SetParent(blizzHider)
StanceBarLeft:SetTexture(nil)
StanceBarMiddle:SetTexture(nil)
StanceBarRight:SetTexture(nil)
SlidingActionBarTexture0:SetTexture(nil)
SlidingActionBarTexture1:SetTexture(nil)
MainMenuBarRightEndCap:Hide()
MainMenuBarLeftEndCap:Hide()
MainMenuBarTexture0:SetTexture(nil)
MainMenuBarTexture1:SetTexture(nil)
MainMenuBarTexture2:SetTexture(nil)
MainMenuBarTexture3:SetTexture(nil)
MainMenuBarLeftEndCap:SetTexture(nil)
MainMenuBarRightEndCap:SetTexture(nil)
MainMenuBarTexture3:Hide()
MainMenuBarTexture2:Hide()