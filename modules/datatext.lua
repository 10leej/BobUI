--This is my version of nStats by Game92
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace

if not cfg.DataText then return end--module control

local addon = CreateFrame("Button", "BobInfo", UIParent)

local color, lag, fps, text, memory, blizz, total, nr, entry
color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]

local memformat = function(number)
	if number > 1024 then
		return string.format("%.2f mb", (number / 1024))
	else
		return string.format("%.1f kb", floor(number))
	end
end

local addoncompare = function(a, b)
	return a.memory > b.memory
end

function addon:new()
	text = self:CreateFontString(nil, "OVERLAY")
	text:SetFont(cfg.font, cfg.DataText.fontsize, cfg.style)

	text:SetPoint("BOTTOMLEFT", self)
	text:SetTextColor(color.r, color.g, color.b)

	self:SetPoint(unpack(cfg.DataText.position))
	self:SetWidth(50)
	self:SetHeight(13)
	
	self:SetScript("OnUpdate", self.update)
	self:SetScript("OnEnter", self.enter)
	self:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

local last = 0
function addon:update(elapsed)
	last = last + elapsed
	
	if last > 1 then	
		fps = GetFramerate()
		fps = "|c00ffffff"..floor(fps).."|r fps "
		
		lag = select(3, GetNetStats())
		lag = "|c00ffffff"..lag.."|r ms "
		
		last = 0

		text:SetText(fps..lag)
		self:SetWidth(text:GetStringWidth())
	end
end

function addon:enter()
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -50, 50)
 	GameTooltip:AddDoubleLine("Addon Name", "Memory Usage", color.r, color.g, color.b, color.r, color.g, color.b)
	GameTooltip:AddLine(" ")

	blizz = collectgarbage("count")
	addons = {}
	total = 0
	nr = 0
	
	UpdateAddOnMemoryUsage()
	
	for i=1, GetNumAddOns(), 1 do
		if (GetAddOnMemoryUsage(i) > 0 ) then
			memory = GetAddOnMemoryUsage(i)
			entry = {name = GetAddOnInfo(i), memory = memory}
			table.insert(addons, entry)
			total = total + memory
		end
	end
	
	table.sort(addons, addoncompare)
	
	for _, entry in pairs(addons) do
		if nr < cfg.DataText.addonlist then
			GameTooltip:AddDoubleLine(entry.name, memformat(entry.memory), 1, 1, 1, 1, 1, 1)
			nr = nr + 1
		end
	end
	
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Total", memformat(total), color.r, color.g, color.b, color.r, color.g, color.b)
	GameTooltip:AddDoubleLine("Total with Default UI", memformat(blizz), color.r, color.g, color.b, color.r, color.g, color.b)
	GameTooltip:Show()
end

addon:new()