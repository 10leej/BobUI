--this is a file for developers that wants to test stuff.
local _, cfg = ... --import config
local addon, ns = ... --get addon namespace

--this is a file for developers that wants to test stuff.

--[[
--Phanx posted this, I'll have to see what i can do if this fixes the chat window issue I'm seeing
--https://authors.curseforge.com/forums/world-of-warcraft/general-chat/need-help/216544-whisper-tabs-chat-frames-11-revert-to-default

-- Table to keep track of frames you already saw:
local frames = {}

-- Function to handle customzing a chat frame:
local function ProcessFrame(frame)
	if frames[frame] then return end

	-- Do all frame customization here.

	frames[frame] = true
end

-- Get all of the permanent chat windows and customize them:
for i = 1, NUM_CHAT_WINDOWS do
	ProcessFrame(_G["ChatFrame" .. i])
end

-- Set up a dirty hook to catch temporary windows and customize them when they are created:
local old_OpenTemporaryWindow = FCF_OpenTemporaryWindow
FCF_OpenTemporaryWindow = function(...)
	local frame = old_OpenTemporaryWindow(...)
	ProcessFrame(frame)
	return frame
end

]]