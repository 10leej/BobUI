--this addon handles all announces
local _, cfg = ...
local addon, ns = ...

--Interrupts
if cfg.Interrupts then
	local Interrupted = CreateFrame('Frame')
	local function OnEvent(self, event, ...)
		if select(2,...) ~= 'SPELL_INTERRUPT' then return end
		if select(5,...) ~= UnitName('player') then return end
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15 = ...
		if IsInGroup() or IsInRaid() then --Group check
			SendChatMessage('Interrupted ' .. GetSpellLink(arg15), cfg.channelannounce)
		elseif not IsInGroup() or IsInRaid() then --Solo check
			print('Interrupted ' .. GetSpellLink(arg15))
		end
	end
	Interrupted:SetScript('OnEvent', OnEvent)
	Interrupted:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
end

--[[
if cfg.dispels then
	local Dispelled = CreateFrame('Frame')
	local function OnEvent(self, event, ...)
		if select(2,...) ~= 'SPELL_DISPEL' then return end
		if select(5,...) ~= UnitName('player') then return end
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15 = ...
		if IsInGroup() or IsInRaid() then --Group check
			SendChatMessage('Dispelled ' .. GetSpellLink(arg15), cfg.channelannounce)
		elseif not IsInGroup() or IsInRaid() then --Solo check
			print('Dispelled ' .. GetSpellLink(arg15))
		end
	end
	Dispelled:SetScript('OnEvent', OnEvent)
	Dispelled:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
end

if cfg.spellsteal then
	local Stolen = CreateFrame('Frame')
	local function OnEvent(self, event, ...)
		if select(2,...) ~= 'SPELL_STOLEN' then return end
		if select(5,...) ~= UnitName('player') then return end
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15 = ...
		if IsInGroup() or IsInRaid() then --Group check
			SendChatMessage('Stolen ' .. GetSpellLink(arg15), cfg.channelannounce)
		elseif not IsInGroup() or IsInRaid() then --Solo check
			print('Stolen ' .. GetSpellLink(arg15))
		end
	end
	Stolen:SetScript('OnEvent', OnEvent)
	Stolen:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
end
]]

--Resurrection spells
if cfg.rez then
	local frame = CreateFrame("Frame", nil, UIParent);
	function DoOnSpellCast(self, event, ...)
		local unitID, spell, rank, target = ...;
		local inInstance, instanceType = IsInInstance();
		if (spell == "Revive" or spell == "Mass Resurrection" or spell == "Raise Ally" or spell == "Rebirth" or spell == "Ancestral Spirit" or spell == "Resurrection" or spell == "Redemption") then
			local correctedtarget = target;
			if (target == "Unknown" or target == nil) then
				correctedtarget = getglobal("GameTooltipTextLeft1"):GetText();
			end
			if (spell == "Mass Resurrection") then 
				correctedtarget = "all the dead people."; 
			end
			SendChatMessage("Casting " .. spell .. " on " .. correctedtarget .. ".", cfg.channelannounce);
		end
	end
	frame:RegisterEvent("UNIT_SPELLCAST_SENT");
	frame:SetScript("OnEvent", DoOnSpellCast);
end