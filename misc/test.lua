--this is a file for developers that wants to test stuff.
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace

--this is a file for developers that wants to test stuff.

--[[ 
--desperately trying to move the durability frame, guess it's not gonna happen
local function DFmove()
	print("Fired: Function 'DurabilityFrame_SetAlerts'") --debug
	local f = CreateFrame("Frame", "BobDFmover", UIParent)
	f:SetScript("OnEvent", function(self, event, unit)
	f:UnregisterEvent(event)
		print("Fired After Function: UPDATE_INVENTORY_DURABILITY")
		DurabilityFrame:ClearAllPoints()
		DurabilityFrame:SetPoint("CENTER",UIParent,"CENTER",0,0)
		print("frame moved by event in function")
	end)
	f:RegisterEvent("PLAYER_LOGIN")
	f:RegisterEvent('UPDATE_INVENTORY_DURABILITY')
end
hooksecurefunc("DurabilityFrame_SetAlerts", DFmove)

local f = CreateFrame("Frame", "BobDFmover", UIParent)
f:SetScript("OnEvent", function(self, event, unit)
f:UnregisterEvent(event)
	print("Fired Event")
	DurabilityFrame:ClearAllPoints()
	DurabilityFrame:SetPoint("CENTER",UIParent,"CENTER",0,0)
	print("Frame moved by event")
end)
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent('UPDATE_INVENTORY_DURABILITY')
f:RegisterEvent('UNIT_INVENTORY_CHANGED')
]]