--inspired by Zork's rTooltip
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check

if not cfg.ToolTip then return end

-----------------------------------------------
--function library
-----------------------------------------------
--backdrop function
if IsAddOnLoaded("Aurora") then return end
local function CreateBackdrop(frame)
  frame:SetBackdrop({bgFile = cfg.backdrop,edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = cfg.pixelbordersize, 
    insets = {top = 2, left = 2, bottom = 2, right = 2}})
  frame:SetBackdropColor(unpack(cfg.bColor))
  frame:SetBackdropBorderColor(unpack(cfg.bColor))
  if isBeautiful then
    frame:CreateBeautyBorder(cfg.border.size.large)
	frame:SetBeautyBorderPadding(3)
    frame:SetBeautyBorderTexture(cfg.border.texture)
    frame:SetBeautyBorderColor(unpack(cfg.border.color))
  end
end
--make some function we'll call later
--func TooltipOnShow
local function TooltipOnShow(self,...)
  CreateBackdrop(self)
end

-----------------------------------------------
--ENHANCED! really this is all we're adding.
-----------------------------------------------
--hide tooltip in combat
if cfg.tooltip.HideTipInCombat then
	GameTooltip:HookScript("OnShow", function(self)
		if InCombatLockdown() then
			self:Hide()
		end
	end)
end

-----------------------------------------------
--Now to style it
-----------------------------------------------

GameTooltipHeaderText:SetFont(cfg.font, 14, nil)
GameTooltipText:SetFont(cfg.font, 12, nil)
Tooltip_Small:SetFont(cfg.font, 11, nil)

--gametooltip statusbar that no one actually uses, wish we could just remove it
GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar:SetPoint("LEFT",5,0)
GameTooltipStatusBar:SetPoint("RIGHT",-5,0)
GameTooltipStatusBar:SetPoint("BOTTOM",GameTooltipStatusBar:GetParent(),"TOP",0,0)  
GameTooltipStatusBar:SetHeight(10)
GameTooltipStatusBar:SetStatusBarTexture(cfg.statusbar_texture)
if isBeautiful then
	GameTooltipStatusBar:CreateBeautyBorder(cfg.border.size.large)
	GameTooltipStatusBar:SetBeautyBorderTexture(cfg.border.texture)
	GameTooltipStatusBar:SetBeautyBorderColor(unpack(cfg.border.color))
	GameTooltipStatusBar:SetBeautyBorderPadding(2)
end
--HookScript GameTooltip OnTooltipCleared
GameTooltip:HookScript("OnTooltipCleared", function(self)
	GameTooltip_ClearStatusBars(self)
end)

--Set position for tooltip
hooksecurefunc("GameTooltip_SetDefaultAnchor", function (tooltip, parent)
	tooltip:SetOwner(parent, "ANCHOR_NONE")
	tooltip:SetPoint(unpack(cfg.tooltip.position))
end)
  
--loop over tooltips
local tooltips = { GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, WorldMapTooltip, }
for idx, tooltip in ipairs(tooltips) do
	CreateBackdrop(tooltip)
	tooltip:HookScript("OnShow", TooltipOnShow)
end