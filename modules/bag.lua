local _, cfg = ... --import config
local addon, ns = ... --get addon namespace
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check
local AuroraCheck = IsAddOnLoaded("Aurora")

if not cfg.bags then return end
if AuroraCheck then return end
--this is a classic bags layout originally started in AftermathUI that I more or less forked

local _G = _G -- import globals for faster usage

--backdrop function
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

--bags
local ContainerFrame1bg = CreateFrame('Frame', nil, _G['ContainerFrame1'])              
ContainerFrame1bg:SetPoint('TOPLEFT', 8, -9)
ContainerFrame1bg:SetPoint('BOTTOMRIGHT', -4, 3)
ContainerFrame1bg:SetFrameStrata("HIGH")
ContainerFrame1bg:SetFrameLevel(3)
CreateBackdrop(ContainerFrame1bg)

local BagFramez = {'ContainerFrame2', 'ContainerFrame3', 'ContainerFrame4', 'ContainerFrame5', 'ContainerFrame6', 'ContainerFrame7', 'ContainerFrame8',  'ContainerFrame9', 'ContainerFrame10', 'ContainerFrame11', 'ContainerFrame12'}
for i = 1, getn(BagFramez) do
  local ContainerFramebg = CreateFrame('Frame', nil, _G[BagFramez[i]])
  ContainerFramebg:SetPoint('TOPLEFT', 8, -4)
  ContainerFramebg:SetPoint('BOTTOMRIGHT', -4, 3)
  ContainerFramebg:SetFrameStrata("HIGH")
  ContainerFramebg:SetFrameLevel(3)
  CreateBackdrop(ContainerFramebg)
end

--bank
_G["BankFrameMoneyFrameInset"]:Hide()
_G["BankFrameMoneyFrameBorder"]:Hide()
_G["BankFrameCloseButton"]:Hide()
for i = 1, 80 do -- Hide the regions.  There are 80, but there is an included fail-safe.
  local region = select(i, _G["BankFrame"]:GetRegions())
  if not region then break else region:SetAlpha(0) end
end
                                
local BankFramebg = CreateFrame('Frame', nil, _G['BankFrame'])
BankFramebg:SetPoint('TOPLEFT', -35, 45)
BankFramebg:SetPoint('BOTTOMRIGHT', 20, -10)
CreateBackdrop(BankFramebg)

for i = 1, 28 do
  --_G["BankFrameItem"..i.."IconQuestTexture"]:SetAlpha(0)
   _G["BankFrameItem"..i]:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8x8",
      insets = {top = -1, left = -1, bottom = -1, right = -1}, 
    })
  _G["BankFrameItem"..i]:SetBackdropColor(unpack(cfg.bColor))
end
                

--Set the search boxes
if isBeautiful then
  _G["BagItemSearchBox"]:CreateBeautyBorder(cfg.border.size.large)
  _G["BagItemSearchBox"]:SetBeautyBorderPadding(5, 0, 0, 0, 5, 0, 0, 0)
  _G["BankItemSearchBox"]:CreateBeautyBorder(cfg.border.size.large)
  _G["BankItemSearchBox"]:SetBeautyBorderPadding(6, 1, 1, 1, 6, 1, 1, 1)
  _G["BagItemAutoSortButton"]:CreateBeautyBorder(cfg.border.size.large)
  _G["BankItemAutoSortButton"]:CreateBeautyBorder(cfg.border.size.large)
end

--because it wants to be special
hooksecurefunc("ContainerFrame_Update", function(frame)
  _G["BagItemSearchBox"]:ClearAllPoints()
  _G["BagItemSearchBox"]:SetWidth(130)
  _G["BagItemSearchBox"]:SetHeight(23)
  _G["BagItemSearchBox"]:SetPoint('BOTTOM', _G["ContainerFrame1"], 'TOP', -7, -58)
  --_G["BagItemSearchBox"]:SetFrameLevel(20) --make sure it's on top of the frames
  
  _G["BagItemAutoSortButton"]:ClearAllPoints()
  _G["BagItemAutoSortButton"]:SetPoint('LEFT', _G["BagItemSearchBox"], 'RIGHT', 3, 0)
  _G["BagItemAutoSortButton"]:SetSize(25,25)
  --_G["BagItemAutoSortButton"]:SetFrameLevel(20) --make sure it's on top of the frames
end)

--hide stuff we don't want
for i = 1, 12 do
  _G["ContainerFrame"..i.."CloseButton"]:Hide() --might show it in the future, not sure
  for p = 1, 7 do
    select(p, _G["ContainerFrame"..i]:GetRegions()):SetAlpha(0)
  end
end
_G["BackpackTokenFrame"]:GetRegions():SetAlpha(0)

--Set the currency
for _, frame in pairs({
  _G["ContainerFrame1MoneyFrameGoldButton"],_G["ContainerFrame1MoneyFrameSilverButton"],_G["ContainerFrame1MoneyFrameCopperButton"],_G["BackpackTokenFrameToken1"],_G["BackpackTokenFrameToken2"],_G["BackpackTokenFrameToken3"],
}) do
  frame:SetFrameStrata("HIGH")
  frame:SetFrameLevel(4)
end
BankFrameMoneyFrame:ClearAllPoints()
BankFrameMoneyFrame:SetPoint("TOPRIGHT",BankFrame,-10,0)

--generate the frames
hooksecurefunc("ContainerFrame_GenerateFrame", function(frame)
  local name = frame:GetName();
  for i = 1, MAX_CONTAINER_ITEMS do
    if isBeautiful then
      _G[name.."Item"..i]:CreateBeautyBorder(cfg.border.size.large+1)
      _G[name.."Item"..i]:SetBeautyBorderTexture(cfg.border.texture)
      _G[name.."Item"..i]:SetBeautyBorderColor(unpack(cfg.border.color))
    end
    _G[name.."Item"..i]:SetFrameStrata("HIGH")
    _G[name.."Item"..i]:SetFrameLevel(4)
    _G[name.."Item"..i]:SetBackdrop({
      bgFile = "Interface\\Buttons\\WHITE8x8",
        insets = {top = -1, left = -1, bottom = -1, right = -1}, 
      })
    _G[name.."Item"..i]:SetBackdropColor(unpack(cfg.bColor))
    _G[name.."Item"..i]:SetNormalTexture("")
    _G[name.."Item"..i.."IconQuestTexture"]:SetAlpha(0)
    _G[name.."Item"..i.."Count"]:SetPoint('BOTTOMRIGHT', -3, 3)
  end
end)