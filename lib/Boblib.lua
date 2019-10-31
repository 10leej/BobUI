--probably might use this in the future? maybe?
local _, cfg = ...
local addon, ns = ...

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