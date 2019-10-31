--This is just a setup of 6 individual basic frames
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check

if not cfg.Panels then return end --module control

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

--Create a some panels
if cfg.panels.A.enable then
  local frame = CreateFrame("Frame", "BobPanelA", UIParent)
  frame:SetWidth(cfg.panels.A.width)
  frame:SetHeight(cfg.panels.A.height)
  frame:SetPoint(unpack(cfg.panels.A.position))
  CreateBackdrop(frame)
  frame:SetFrameStrata("BACKGROUND")
end
if cfg.panels.B.enable then
  local frame = CreateFrame("Frame", "BobPanelB", UIParent)
  frame:SetWidth(cfg.panels.B.width)
  frame:SetHeight(cfg.panels.B.height)
  frame:SetPoint(unpack(cfg.panels.B.position))
  CreateBackdrop(frame)
  frame:SetFrameStrata("BACKGROUND")
end
if cfg.panels.C.enable then
  local frame = CreateFrame("Frame", "BobPanelC", UIParent)
  frame:SetWidth(cfg.panels.C.width)
  frame:SetHeight(cfg.panels.C.height)
  frame:SetPoint(unpack(cfg.panels.C.position))
  CreateBackdrop(frame)
  frame:SetFrameStrata("BACKGROUND")
end
if cfg.panels.D.enable then
  local frame = CreateFrame("Frame", "BobPanelD", UIParent)
  frame:SetWidth(cfg.panels.D.width)
  frame:SetHeight(cfg.panels.D.height)
  frame:SetPoint(unpack(cfg.panels.D.position))
  CreateBackdrop(frame)
  frame:SetFrameStrata("BACKGROUND")
end
if cfg.panels.E.enable then
  local frame = CreateFrame("Frame", "BobPanelD", UIParent)
  frame:SetWidth(cfg.panels.E.width)
  frame:SetHeight(cfg.panels.E.height)
  frame:SetPoint(unpack(cfg.panels.E.position))
  CreateBackdrop(frame)
  frame:SetFrameStrata("BACKGROUND")
end
if cfg.panels.F.enable then
  local frame = CreateFrame("Frame", "BobPanelD", UIParent)
  frame:SetWidth(cfg.panels.F.width)
  frame:SetHeight(cfg.panels.F.height)
  frame:SetPoint(unpack(cfg.panels.F.position))
  CreateBackdrop(frame)
  frame:SetFrameStrata("BACKGROUND")
end