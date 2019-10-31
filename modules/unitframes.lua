local _, cfg = ... --import config
local addon, ns = ... --get addon namespace

--modified whoaUnitframes
if not cfg.Unitframes then return end --module control

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

--	Player frame.
function wPlayerFrame(self)
	CreateBackdrop(PlayerFrame)
	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetPoint(cfg.player.position)
	PlayerFrame:SetSize(cfg.player.width,cfg.player.height)
	PlayerFrameTexture:SetTexture(nil)
	PlayerFrameBackground:Hide()
	
	--Name
	self.name:Hide()
	self.name:ClearAllPoints()
	self.name:SetPoint("CENTER", PlayerFrame, "CENTER",50.5, 36)
	--Health Bar
	PlayerFrameHealthBar:SetStatusBarTexture(cfg.statusbar_texture)
	self.healthbar:ClearAllPoints()
	self.healthbar:SetPoint("TOP",PlayerFrame,0,0)
	self.healthbar:SetHeight(18)
	self.healthbar:SetWidth(18)
	PlayerFrameHealthBar:CreateBeautyBorder(cfg.border.size.large)
	PlayerFrameHealthBar:SetBeautyBorderPadding(1)
	--Mana Bar
	PlayerFrameManaBar:SetStatusBarTexture(cfg.statusbar_texture)
	self.manabar:ClearAllPoints()
	self.manabar:SetPoint("BOTTOM",PlayerFrame,0,0)
	self.manabar:SetHeight(18);
	self.manabar:SetWidth(18);
	PlayerFrameManaBar:CreateBeautyBorder(cfg.border.size.large)
	PlayerFrameManaBar:SetBeautyBorderPadding(1)
	
	self.healthbar.LeftText:ClearAllPoints();
	self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"LEFT",5,0);	
	self.healthbar.RightText:ClearAllPoints();
	self.healthbar.RightText:SetPoint("RIGHT",self.healthbar,"RIGHT",-5,0);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
	
	self.manabar.LeftText:ClearAllPoints();
	self.manabar.LeftText:SetPoint("LEFT",self.manabar,"LEFT",5,0);
	self.manabar.RightText:ClearAllPoints();
	self.manabar.RightText:SetPoint("RIGHT",self.manabar,"RIGHT",-5,0);
	self.manabar.TextString:SetPoint("CENTER",self.manabar,"CENTER",0,0);
	
	self.healthbar.LeftText:SetFontObject(SystemFont_Outline_Small);
	self.healthbar.RightText:SetFontObject(SystemFont_Outline_Small);
	
	self.manabar.LeftText:SetFontObject(SystemFont_Outline_Small);
	self.manabar.RightText:SetFontObject(SystemFont_Outline_Small);
	self.manabar.TextString:SetFontObject(SystemFont_Outline_Small);
	PlayerFrameGroupIndicatorText:ClearAllPoints();
	PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame,"TOP",0,-20);
	PlayerFrameGroupIndicatorLeft:Hide();
	PlayerFrameGroupIndicatorMiddle:Hide();
	PlayerFrameGroupIndicatorRight:Hide();
	PlayerPortrait:Hide();
end
hooksecurefunc("PlayerFrame_ToPlayerArt", wPlayerFrame)

-- Pet frame
function whoaPetFrame()
	PetFrameHealthBarTextLeft:SetPoint("LEFT",PetFrameHealthBar,"LEFT",0,0);
	PetFrameHealthBarTextRight:SetPoint("RIGHT",PetFrameHealthBar,"RIGHT",0,0);
	PetFrameManaBarTextLeft:SetPoint("LEFT",PetFrameManaBar,"LEFT",0,-2);
	PetFrameManaBarTextRight:SetPoint("RIGHT",PetFrameManaBar,"RIGHT",0,-2);
	PetFrameHealthBarTextLeft:SetFontObject(SystemFont_Outline_Small);
	PetFrameHealthBarTextRight:SetFontObject(SystemFont_Outline_Small);
	PetFrameManaBarTextLeft:SetFontObject(SystemFont_Outline_Small);
	PetFrameManaBarTextRight:SetFontObject(SystemFont_Outline_Small);
end
hooksecurefunc("PlayerFrame_ToPlayerArt", whoaPetFrame)

function whoaPetFrameBg()
	local f = CreateFrame("Frame",nil,PetFrame)
	f:SetFrameStrata("BACKGROUND")
	f:SetSize(70,18);
	local t = f:CreateTexture(nil,"BACKGROUND")
	t:SetColorTexture(0, 0, 0, 0.5)
	t:SetAllPoints(f)
	f.texture = t
	f:SetPoint("CENTER",16,-5);
	f:Show()
end
whoaPetFrameBg();