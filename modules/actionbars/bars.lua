--Stripped down version of Zork's rActionBarStyler
local _, cfg = ...
local addon, ns = ...
local isBeautiful = IsAddOnLoaded("!Beautycase") --!Beautycase check

if not cfg.ActionBars then return end --module control

--declare some local functions
local function fade(frame,button)
	frame:EnableMouse(true)
	frame:SetAlpha(cfg.fadealpha)
	frame:SetScript("OnEnter", function(self) frame:SetAlpha(cfg.alpha) end)
	frame:SetScript("OnLeave", function(self) frame:SetAlpha(cfg.fadealpha) end)
	button:HookScript("OnEnter", function(self) frame:SetAlpha(cfg.alpha) end)
	button:HookScript("OnLeave", function(self) frame:SetAlpha(cfg.fadealpha) end)
end
local function CreateBackdrop(frame)
    frame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = cfg.pixelbordersize, 
        insets = {top = 2, left = 2, bottom = 2, right = 2}})
    frame:SetBackdropColor(unpack(cfg.bColor))
    frame:SetBackdropBorderColor(unpack(cfg.bColor))
	if isBeautiful then
		frame:CreateBeautyBorder(cfg.border.size.large)
		frame:SetBeautyBorderTexture(cfg.border.texture)
		frame:SetBeautyBorderColor(unpack(cfg.border.color))
	end
end

--kill micromenu (or rather just make it too small to see then set the button to non interactive (just in case)
CharacterMicroButton:SetScale(0.0001)
CharacterMicroButton:EnableMouse(false)
SpellbookMicroButton:SetScale(0.0001)
SpellbookMicroButton:EnableMouse(false)
TalentMicroButton:SetScale(0.0001)
TalentMicroButton:EnableMouse(false)
AchievementMicroButton:SetScale(0.0001)
AchievementMicroButton:EnableMouse(false)
QuestLogMicroButton:SetScale(0.0001)
QuestLogMicroButton:EnableMouse(false)
GuildMicroButton:SetScale(0.0001)
GuildMicroButton:EnableMouse(false)
LFDMicroButton:SetScale(0.0001)
LFDMicroButton:EnableMouse(false)
EJMicroButton:SetScale(0.0001)
EJMicroButton:EnableMouse(false)
MainMenuMicroButton:SetScale(0.0001)
MainMenuMicroButton:EnableMouse(false)
HelpMicroButton:SetScale(0.0001)
HelpMicroButton:EnableMouse(false)
CollectionsMicroButton:SetScale(0.0001)
CollectionsMicroButton:EnableMouse(false)
StoreMicroButton:SetScale(0.0001)
StoreMicroButton:EnableMouse(false)

--hide macro text
if cfg.hidemacro then
	for i=1, 12 do
		_G["ActionButton"..i.."Name"]:SetAlpha(0) -- main bar
		_G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0) -- bottom right bar
		_G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0) -- bottom left bar
		_G["MultiBarRightButton"..i.."Name"]:SetAlpha(0) -- right bar
		_G["MultiBarLeftButton"..i.."Name"]:SetAlpha(0) -- left bar
	end
end
--hide hotkey
if cfg.hidehotkey then
	for i=1, 12 do
		_G["ActionButton"..i.."HotKey"]:SetAlpha(0) -- main bar
		_G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0) -- bottom right bar
		_G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0) -- bottom left bar
		_G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0) -- right bar
		_G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(0) -- left bar
	end
end

--Lets get our hands dirty now, easy stuff is over.
local num = NUM_ACTIONBAR_BUTTONS
local buttonList = {}

------------[[Bar 1]]------------
--create the frame to hold the buttons
local frame = CreateFrame("Frame", "Bob_MainMenuBar", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.bar1.size + (num-1)*cfg.bar1.margin + 2*cfg.bar1.margin)
frame:SetHeight(cfg.bar1.size + 2*cfg.bar1.margin)
frame:SetPoint(unpack(cfg.bar1.position))
frame:SetScale(cfg.bar1.scale)
--move the buttons into position and reparent them
MainMenuBarArtFrame:SetParent(frame)
MainMenuBarArtFrame:EnableMouse(false)
for i=1, num do
	local button = _G["ActionButton"..i]
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.bar1.size, cfg.bar1.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
		button:SetPoint("BOTTOMLEFT", frame, cfg.bar1.margin, cfg.bar1.margin)
	else
		local previous = _G["ActionButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", cfg.bar1.margin, 0)
	end
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")
--Mouseover fading
if cfg.bar1.fade then
	for i = 1, num do 
		fade( frame, _G["ActionButton"..i] )
	end
end

------------[[Bar 2]]------------
local frame = CreateFrame("Frame", "Bob_MultiBarBottomLeft", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.bar2.size + (num-1)*cfg.bar2.margin + 2*cfg.bar2.padding)
frame:SetHeight(cfg.bar2.size + 2*cfg.bar2.padding)
frame:SetPoint(unpack(cfg.bar2.position))
frame:SetScale(cfg.bar2.scale)
--move the buttons into position and reparent them
MultiBarBottomLeft:SetParent(frame)
MultiBarBottomLeft:EnableMouse(false)
for i=1, num do
	local button = _G["MultiBarBottomLeftButton"..i]
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.bar2.size, cfg.bar2.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
	button:SetPoint("BOTTOMLEFT", frame, cfg.bar2.padding, cfg.bar2.padding)
	else
	local previous = _G["MultiBarBottomLeftButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", cfg.bar2.margin, 0)
	end
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")
--Mouseover fading
if cfg.bar2.fade then
	for i = 1, num do 
		fade( frame, _G["MultiBarBottomLeftButton"..i] )
	end
end

------------[[Bar 3]]------------
local frame = CreateFrame("Frame", "Bob_MultiBarBottomRight", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.bar3.size + (num-1)*cfg.bar3.margin + 2*cfg.bar3.padding)
frame:SetHeight(cfg.bar3.size + 2*cfg.bar3.padding)
frame:SetPoint(unpack(cfg.bar3.position))
frame:SetScale(cfg.bar3.scale)
--move the buttons into position and reparent them
MultiBarBottomRight:SetParent(frame)
MultiBarBottomRight:EnableMouse(false)
for i=1, num do
	local button = _G["MultiBarBottomRightButton"..i]
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.bar3.size, cfg.bar3.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
		button:SetPoint("BOTTOMLEFT", frame, cfg.bar3.padding, cfg.bar3.padding)
	else
		local previous = _G["MultiBarBottomRightButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", cfg.bar3.margin, 0)
	end
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")
--Mouseover fading
if cfg.bar3.fade then
	for i = 1, num do 
		fade( frame, _G["MultiBarBottomRightButton"..i] )
	end
end

------------[[Left Bar]]------------
--create the frame to hold the buttons
local frame = CreateFrame("Frame", "Bob_MultiBarLeft", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.bar4.size + (num-1)*-cfg.bar4.margin + 2*cfg.bar4.padding)
frame:SetHeight(cfg.bar4.size + 2*cfg.bar4.padding)
frame:SetPoint(unpack(cfg.bar4.position))
frame:SetScale(cfg.bar4.scale)
frame:SetFrameStrata("BACKGROUND")
--move the buttons into position and reparent them
MultiBarLeft:SetParent(frame)
MultiBarLeft:EnableMouse(false)
for i=1, num do
	local button = _G["MultiBarLeftButton"..i]
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.bar4.size, cfg.bar4.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
	button:SetPoint("BOTTOMLEFT", frame, cfg.bar4.padding, cfg.bar4.padding)
	else
		local previous = _G["MultiBarLeftButton"..i-1]
		button:SetPoint("TOP", previous, "BOTTOM", 0, -cfg.bar4.margin)
	end
end
if cfg.bar4.use6x2 then
	MultiBarLeftButton7:ClearAllPoints()
	MultiBarLeftButton7:SetPoint("TOPLEFT",MultiBarLeftButton1,"TOPLEFT",cfg.bar4.size+4,0)
end
if not cfg.bar4.use6x2 and cfg.bar4.use4x3 then
	MultiBarLeftButton5:ClearAllPoints()
	MultiBarLeftButton5:SetPoint("TOPLEFT",MultiBarLeftButton1,"TOPLEFT",cfg.bar4.size+4,0)
	MultiBarLeftButton9:ClearAllPoints()
	MultiBarLeftButton9:SetPoint("TOPLEFT",MultiBarLeftButton5,"TOPLEFT",cfg.bar4.size+4,0)
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")
--Mouseover fading
if cfg.bar4.fade then
	for i = 1, num do 
		fade( frame, _G["MultiBarLeftButton"..i] )
	end
end

------------[[Right Bar]]------------
local frame = CreateFrame("Frame", "Bob_MultiBarRight", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.bar5.size + (num-1)*-cfg.bar5.margin + 2*cfg.bar5.padding)
frame:SetHeight(cfg.bar5.size + 2*cfg.bar5.padding)
frame:SetPoint(unpack(cfg.bar5.position))
frame:SetScale(cfg.bar5.scale)
frame:SetFrameStrata("BACKGROUND")
--move the buttons into position and reparent them
MultiBarRight:SetParent(frame)
MultiBarRight:EnableMouse(false)
for i=1, num do
	local button = _G["MultiBarRightButton"..i]
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.bar5.size, cfg.bar5.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
	button:SetPoint("BOTTOMRIGHT", frame, cfg.bar5.padding, cfg.bar5.padding)
	else
	local previous = _G["MultiBarRightButton"..i-1]
		button:SetPoint("TOP", previous, "BOTTOM", 0, -cfg.bar5.margin)
	end
end
if cfg.bar5.use6x2 then
	MultiBarRightButton7:ClearAllPoints()
	MultiBarRightButton7:SetPoint("TOPLEFT",MultiBarRightButton1,"TOPLEFT",-cfg.bar5.size-4,0)
end
if not cfg.bar5.use6x2 and cfg.bar5.use4x3 then
	MultiBarRightButton5:ClearAllPoints()
	MultiBarRightButton5:SetPoint("TOPLEFT",MultiBarRightButton1,"TOPLEFT",-cfg.bar4.size-4,0)
	MultiBarRightButton9:ClearAllPoints()
	MultiBarRightButton9:SetPoint("TOPLEFT",MultiBarRightButton5,"TOPLEFT",-cfg.bar4.size-4,0)
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")
--Mouseover fading
if cfg.bar5.fade then
	for i = 1, num do 
		fade( frame, _G["MultiBarRightButton"..i] )
	end
end
------------[[LeaveVehicle]]------------
--create the frame to hold the buttons
local frame = CreateFrame("Frame", "Bob_LeaveVehicle", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.vehicle.size + (num-1)*cfg.vehicle.margin + 2*cfg.vehicle.padding)
frame:SetHeight(cfg.vehicle.size + 2*cfg.vehicle.padding)
frame:SetPoint(unpack(cfg.vehicle.position))
frame:SetScale(cfg.vehicle.scale)
--the button
local button = CreateFrame("BUTTON", "Bob_LeaveVehicle", frame, "SecureHandlerClickTemplate, SecureHandlerStateTemplate");
table.insert(buttonList, button) --add the button object to the list
button:SetSize(cfg.vehicle.size, cfg.vehicle.size)
button:SetPoint("BOTTOMLEFT", frame, cfg.vehicle.padding, cfg.vehicle.padding)
button:RegisterForClicks("AnyUp")
button:SetScript("OnClick", function(self) VehicleExit() end)
button:SetNormalTexture("INTERFACE\\PLAYERACTIONBARALT\\NATURAL")
button:SetPushedTexture("INTERFACE\\PLAYERACTIONBARALT\\NATURAL")
button:SetHighlightTexture("INTERFACE\\PLAYERACTIONBARALT\\NATURAL")
if isBeautiful then
	button:CreateBeautyBorder(cfg.border.size.large)
	button:SetBeautyBorderPadding(2)
	button:SetBeautyBorderTexture(cfg.border.texture)
	button:SetBeautyBorderColor(unpack(cfg.border.color))
end
local nt = button:GetNormalTexture()
local pu = button:GetPushedTexture()
local hi = button:GetHighlightTexture()
nt:SetTexCoord(0.0859375,0.1679688,0.359375,0.4414063)
pu:SetTexCoord(0.001953125,0.08398438,0.359375,0.4414063)
hi:SetTexCoord(0.6152344,0.6972656,0.359375,0.4414063)
hi:SetBlendMode("ADD")
--the button will spawn if a vehicle exists, but no vehicle ui is in place (the vehicle ui has its own exit button)
RegisterStateDriver(button, "visibility", "[petbattle][overridebar][vehicleui] hide; [possessbar][@vehicle,exists] show; hide")
--frame is visibile when no vehicle ui is visible
RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui] hide; show")

------------[[Override Bar]]------------
--create the frame to hold the buttons
local frame = CreateFrame("Frame", "Bob_OverrideBar", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.bar1.size + (num-1)*cfg.bar1.margin + 2*cfg.bar1.padding)
frame:SetHeight(cfg.bar1.size + 2*cfg.bar1.padding)
frame:SetPoint(unpack(cfg.bar1.position))
frame:SetScale(cfg.bar1.scale)
--move the buttons into position and reparent them
OverrideActionBar:SetParent(frame)
OverrideActionBar:EnableMouse(false)
OverrideActionBar:SetScript("OnShow", nil) --remove the onshow script
local leaveButtonPlaced = false
for i=1, num do
	local button =  _G["OverrideActionBarButton"..i]
	if not button and not leaveButtonPlaced then
		button = OverrideActionBar.LeaveButton --the magic 7th button
		leaveButtonPlaced = true
	end
	if not button then
		break
	end
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.bar1.size, cfg.bar1.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
		button:SetPoint("BOTTOMLEFT", frame, cfg.bar1.padding, cfg.bar1.padding)
	else
		local previous = _G["OverrideActionBarButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", cfg.bar1.margin, 0)
	end
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle] hide; [overridebar][vehicleui][possessbar,@vehicle,exists] show; hide")
RegisterStateDriver(OverrideActionBar, "visibility", "[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide")
	
------------[[Extra Action Bar]]------------
--I got a little lazy with this one.
_G["ExtraActionButton1"]:SetParent(UIParent)
_G["ExtraActionButton1"]:SetSize(cfg.extra.size,cfg.extra.size)
_G["ExtraActionButton1"]:SetPoint(unpack(cfg.extra.position))

------------[[Draenor Action Bar]]------------
--Blizzard wants this to be special for some reason so just hook it our normal way
--create the frame to hold the buttons
local frame = CreateFrame("Frame", "newDraenorBarFrame", UIParent, "SecureHandlerStateTemplate")
frame:SetSize(cfg.extra.size,cfg.extra.size)
frame:SetPoint(unpack(cfg.extra.position))
--reparent frame
DraenorZoneAbilityFrame:SetParent(frame)
DraenorZoneAbilityFrame:EnableMouse(false)
DraenorZoneAbilityFrame:ClearAllPoints()
DraenorZoneAbilityFrame:SetPoint("CENTER")
DraenorZoneAbilityFrame.ignoreFramePositionManager = true
DraenorZoneAbilityFrame.SpellButton.Style:Hide() --hide that art!
--button
local button = DraenorZoneAbilityFrame.SpellButton
button:SetSize(cfg.extra.size,cfg.extra.size)
if isBeautiful then
	button:CreateBeautyBorder(cfg.border.size.large)
	button:SetBeautyBorderTexture(cfg.border.texture)
	button:SetBeautyBorderColor(unpack(cfg.border.color))
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui] hide; show")

------------[[Stance Bar]]------------
local num = NUM_STANCE_SLOTS
local num2 = NUM_POSSESS_SLOTS
--make a frame that fits the size of all microbuttons
local frame = CreateFrame("Frame", "Bob_StanceBar", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.stance.size + (num-1)*cfg.stance.margin + 2*cfg.stance.padding)
frame:SetHeight(cfg.stance.size + 2*cfg.stance.padding)
frame:SetPoint(unpack(cfg.stance.position))
frame:SetScale(cfg.stance.scale)
--move the buttons into position and reparent them
StanceBarFrame:SetParent(frame)
StanceBarFrame:EnableMouse(false)
--fix for button1 placement with only one form
StanceBarFrame:ClearAllPoints()
StanceBarFrame:SetPoint("BOTTOMLEFT",frame,cfg.stance.padding-12,cfg.stance.padding-3)
StanceBarFrame.ignoreFramePositionManager = true
for i=1, num do
	local button = _G["StanceButton"..i]
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.stance.size, cfg.stance.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
		button:SetPoint("BOTTOMLEFT", frame, cfg.stance.padding, cfg.stance.padding)
	else
		local previous = _G["StanceButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", cfg.stance.margin, 0)
	end
end
--POSSESS BAR
--move the buttons into position and reparent them
PossessBarFrame:SetParent(frame)
PossessBarFrame:EnableMouse(false)
for i=1, num2 do
	local button = _G["PossessButton"..i]
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.stance.size, cfg.stance.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
		button:SetPoint("BOTTOMLEFT", frame, cfg.stance.padding, cfg.stance.padding)
	else
		local previous = _G["PossessButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", cfg.stance.margin, 0)
	end
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui] hide; show")
--Mouseover fading
if cfg.stance.fade then
	for i = 1, num do 
		fade( frame, _G["StanceButton"..i] )
	end
	for i = 1, num2 do 
		fade( frame, _G["PossessButton"..i] )
	end
end

------------[[Pet Bar]]------------
local num = NUM_PET_ACTION_SLOTS
--create the frame to hold the buttons
local frame = CreateFrame("Frame", "Bob_PetBar", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(num*cfg.pet.size + (num-1)*cfg.pet.margin + 2*cfg.pet.padding)
frame:SetHeight(cfg.pet.size + 2*cfg.pet.padding)
frame:SetPoint(unpack(cfg.pet.position))
frame:SetScale(cfg.pet.scale)
--move the buttons into position and reparent them
PetActionBarFrame:SetParent(frame)
PetActionBarFrame:EnableMouse(false)
for i=1, num do
	local button = _G["PetActionButton"..i]
	table.insert(buttonList, button) --add the button object to the list
	button:SetSize(cfg.pet.size, cfg.pet.size)
	button:ClearAllPoints()
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
	if i == 1 then
		button:SetPoint("LEFT", frame, cfg.pet.padding, 0)
	else
		local previous = _G["PetActionButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", cfg.pet.margin, 0)
	end
	--cooldown fix
	local cd = _G["PetActionButton"..i.."Cooldown"]
	cd:SetAllPoints(button)
end
--show/hide the frame on a given state driver
RegisterStateDriver(frame, "visibility", "[petbattle] hide; [vehicleui] hide; [@pet,exists,nodead] show; hide")
--Mouseover fading
if cfg.pet.fade then
	for i = 1, num do 
		fade( frame, _G["PetActionButton"..i] )
	end
end
	
------------[[Bag Bar]]------------
local bagbuttonList = {
        MainMenuBarBackpackButton,
        CharacterBag0Slot,
        CharacterBag1Slot,
        CharacterBag2Slot,
        CharacterBag3Slot,
}
local NUM_BAG_BUTTONS = # bagbuttonList
local buttonWidth = MainMenuBarBackpackButton:GetWidth()
local buttonHeight = MainMenuBarBackpackButton:GetHeight()
local gap = 2
--create the frame to hold the buttons
local frame = CreateFrame("Frame", "Bob_BagFrame", UIParent, "SecureHandlerStateTemplate")
frame:SetWidth(NUM_BAG_BUTTONS*buttonWidth + (NUM_BAG_BUTTONS-1)*gap + 2*0)
frame:SetHeight(buttonHeight + 2*0)
frame:SetPoint(unpack(cfg.bag.position))
frame:SetScale(cfg.bag.scale)
--move the buttons into position and reparent them
for _, button in pairs(bagbuttonList) do
	button:SetParent(frame)
	if isBeautiful then
		button:CreateBeautyBorder(cfg.border.size.large)
		button:SetBeautyBorderPadding(2)
		button:SetBeautyBorderTexture(cfg.border.texture)
		button:SetBeautyBorderColor(unpack(cfg.border.color))
	end
end
MainMenuBarBackpackButton:ClearAllPoints();
MainMenuBarBackpackButton:SetPoint("RIGHT", -0, 0)
--Mouseover fading
if cfg.bag.fade then
	for _,button in pairs(bagbuttonList) do fade(frame,button) end
end