local _, cfg = ... --export config
local addon, ns = ... --get addon namespace

--[[
Note to users new to a config.lua file:
	This is a file intended to provide configuration options,you edit these files quite simply. Make a change and 
save the file. You can even edit the files while the game is loaded, just change the value save it then type /reload
or /rl into the game chat to realod the user interface.
	I highly recommend keeping all the punctuation in the same place as it can cause errors if you accident;y remove
a comma.

Regards:
10leej aka Eomi < Jehoovas Witnesses > US - Uther
]]

--Module Control
cfg.ActionBars		= true 	--Actionbars
cfg.bags			= true  --Bags
cfg.auras	 		= true 	--Player Auras Frame
cfg.Chat			= true 	--Chat
cfg.Clock			= true 	--The clock
cfg.DataText		= true 	--Data text
cfg.FilterErrors	= true 	--Error filter (the red text that says your spell is on cooldown)
cfg.lootframes		= true 	--BobUI's loot frames
cfg.Mail			= true 	--Built in mail addon
cfg.Minimap			= true 	--Minimap
cfg.NamePlates		= true 	--Nameplates
cfg.Panels          = true  --Panels (the rectangles
cfg.ToolTip			= true 	--Tooltip
cfg.WatchFrame		= true 	--Watch frame mover (aka quest frame, the tracklist, ect)
cfg.ZoneText		= true 	--the zone text
--------------------------------------------------------------------------------------------------
-------------------------------------------[[UITweaks]]-------------------------------------------
--------------------------------------------------------------------------------------------------
local MediaPath = "Interface\\AddOns\\BobUI\\media\\" --Set the media path

cfg.statusbar_texture = MediaPath.."statusbar" --Set the BobUI StatusBar
cfg.backdrop = "Interface\\Buttons\\WHITE8x8" --backdrop image
cfg.font = "Fonts\\ARIALN.ttf" --BobUI's base font
cfg.style = "THINOUTLINE" 	--OUTLINE, MONOCHROME, or nil

cfg.bColor = { .0, .0, .0, 0.5 }--Set  backround color r,b,g,alpha
cfg.pixelbordersize = 2 --only shows if !Beautycase is disabled
cfg.border = { --!Beautycase border config
	size = { --adjustable border sizes
		large = 12,
		medium = 10,
		small = 8, --smaller frames like the nameplates
	},
	texture = "default", --default, white [[This function does not support aura frames]]
	color = { 1, 1, 1 }, --Colors work best with the white layout [[This function does not support aura frames]]
}
--Enhancements
cfg.AutoScaleUI		= false 	--Auto scales UI to be pixel perfect
cfg.UIscale		 	= 0.711111111 	--Manually set the UI scale (if AutoScale false)
cfg.AutoAcceptRolls = true  --Auto accepts item rolls regardless of need/greed/de
cfg.autoshot		= true  --Auto screenshot on achievements
cfg.automate		= true  --Automated repair (with guild funds) and sell greys
cfg.HideBossEmote	= false --Blizzards stripped down version of a bossmod
cfg.Interrupts		= true  --Announce interrupts
cfg.rez				= true  --Rez announcer --Channels are SAY,EMOTE,PARTY,INSTANCE_CHAT,GUILD,OFFICER,YELL,RAID,RAID_WARNING
cfg.channelannounce = "INSTANCE_CHAT" --Pick a channel to shout in.
cfg.autoquest 		= true --auto accept/complete quests

cfg.panels = { --six panels move em where ya want
    A = {--name: BobPanelA
		enable = true,
		position = { "BOTTOMLEFT", UIParent, 0, 0 },
		width = 404,
		height = 120,
	},
    B =  {--name: BobPanelB
		enable = true,
		position = { "BOTTOMRIGHT", UIParent, 0, 0 },
		width = 404,
		height = 120,
	},
    C = {--name: BobPanelC
		enable = true,
		position = { "BOTTOMLEFT", UIParent, 404, 0 },
		width = 316,
		height = 120,
	},
    D = {--name: BobPanelD
		enable = true,
		position = { "BOTTOMRIGHT", UIParent, -404, 0 },
		width = 316,
		height = 120,
	},
    E = {--name: BobPanelE
		enable = false,
		position = {"CENTER", UIParent, 0, 0},
		width = 60,
		height = 60,
	},
    F = {--name: BobPanelF
		enable = false,
		position = { "CENTER", UIParent, 0, 0 },
		width = 60,
		height = 60,
	},
	
}

--------------------------------------------------------------------------------------------------
-------------------------------------------[[DataText]]-------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.DataText = {
	position = {"TOP", Minimap, "TOP", 0, -6},
	fontsize = 12,
	addonlist = 30, --number of addons you want to show the memory usage for
}
--------------------------------------------------------------------------------------------------
-------------------------------------------[[Tooltip]]--------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.tooltip = {
	position = {"BOTTOMRIGHT", UIParent, -2, 122},
	HideTipInCombat = false, --Hide Tooltip in Combat
	AddSpellID = true, --Add spell ID to tooltip
}
--------------------------------------------------------------------------------------------------
------------------------------------------[[NamePlates]]------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.nameplates = { --we're getting newer fancier ones at some point
	fontsize = 8,					-- Font size for Name and HP text
	fontflag = "THINOUTLINE",		-- Text outline
	hpHeight = 10,					-- Health bar height
	hpWidth = 110,					-- Health bar width
	namecolor = true,				-- Colorize names based on reaction
	raidIconSize = 18,				-- Raid icon size
	combat_toggle = false, 			-- If set to true nameplates will be automatically toggled on when you enter the combat
	castbar = {
		icon_size = 20,				-- Cast bar icon size
		height = 10,					-- Cast bar height
		width = 100,				-- Cast bar width
		cast_time = true,			-- display cast time
	},
}
--------------------------------------------------------------------------------------------------
-------------------------------------------[[Minimap]]--------------------------------------------
--------------------------------------------------------------------------------------------------
--Minimap size
cfg.minimap = {
	position = {'TOPRIGHT',UIParent,0,0},
	width = 180,			
	height = 180,
}
--Zone text
cfg.zone = {
	position = {"TOP", UIParent, "TOP", 0, -3},
	fontsize = 12,
	justify = "CENTER",
}
--Time
cfg.time = {
	position = {"TOP", UIParent, "TOP", 0, -10},
	fontsize = 12,
}
--WatchFrame
cfg.wf = {
	position = {'RIGHT',UIParent,-100,0},
	height = 300,
	autocollapse = true, --collapses objective tracker in arena, boss fights battleground ect
}
cfg.WorldMap = {
    makeMovable = true, --this only works with the smaller world make not the fullscreen
    fadeMapOnMove = true,
    fadeAlpha = .7,
}
--------------------------------------------------------------------------------------------------
---------------------------------------------[[Chat]]---------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.chat = {
	style = nil,
	size = 12,
	style_chat_tabs = true, --false for blizzard style, true for a newer style
}
--EditBox
cfg.ebox = {
	point = {"BOTTOMLEFT", 0, 120},
	width = 404,
	height = 15,
}
--------------------------------------------------------------------------------------------------
-----------------------------------[[Player Buff/Debuff Frame]]-----------------------------------
--------------------------------------------------------------------------------------------------
--Buffs
cfg.buffBorderColor = {.25, .25, .25}
--Debuffs
cfg.buff = { --debuff frame anchors off the bottom of thew buff frame
	position = {"TOPRIGHT", Minimap, "TOPLEFT", -4, -4},
	size = 36,
	scale = 1,
	PerRow = 8,
	paddingX = 5,
	paddingY = 5,
    FontSize = 14,
    CountSize = 16,
	border = 'Interface\\AddOns\\BobUI\\media\\textureBuff',
}
--Debuffs
cfg.debuff = { --debuff frame anchors off the bottom of thew buff frame
	size = 36,
	scale = 1,
	PerRow = 8,
	paddingX = 7,
	paddingY = 7,
    FontSize = 14,
    CountSize = 16,
	border = 'Interface\\AddOns\\BobUI\\media\\textureDebuff',
}
--------------------------------------------------------------------------------------------------
---------------------------------------------[[Bags]]---------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.bags = {
	onebag = true, --enable a one bag option, set to false for classic style bags
	spacing = 2, --space between each button only affects onebag
	bpr = 11, --"buttons per row" only affects onebag
}
--------------------------------------------------------------------------------------------------
------------------------------------------[[ActionBars]]------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.hidemacro = false
cfg.hidehotkey = true
cfg.RangeColoring = true
cfg.alpha = 1
cfg.fadealpha = 0
--Range Coloring
cfg.colors = {
     normal = {r =  1,	g =  1, 	b =  1	},
     pushed = {r =  1,	g =  1, 	b =  1	},
  highlight = {r =  .9,	g =  .8,	b =  .6	},
    checked = {r =  .9,	g =  .8,	b =  .6	},
 outofrange = {r =  .8,	g =  .3, 	b =  .2	},
  outofmana = {r =  .3,	g = .3, 	b =  .7	},
     usable = {r =  1,	g =  1, 	b =  1	},
   unusable = {r = .4,	g = .4, 	b = .4	},
   equipped = {r = .3,	g = .6, 	b = .3	}
}
cfg.bar1 = {
	position = {"BOTTOM",UIParent,0,-2}, --position
	scale = 1, --scale
	size = 36, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = false,
}
cfg.bar2 = {
	position = {"BOTTOM",UIParent,0,42}, --position
	scale = 1, --scale
	size = 36, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = false,
}
cfg.bar3 = {
	position = {"BOTTOM",UIParent,0,82}, --position
	scale = 1, --scale
	size = 36, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = false,
}
cfg.bar4 = {
	position = {"LEFT",UIParent,2,100}, --position
	scale = 1, --scale
	size = 36, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = true,
	use6x2 = true,
}
cfg.bar5 = {
	position = {"RIGHT",UIParent,-2,100}, --position
	scale = 1, --scale
	size = 36, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = true,
	use6x2 = true,
}
cfg.pet = {
	position = {"BOTTOM",UIParent,70,122}, --position
	scale = 1, --scale
	size = 30, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = false,
}
cfg.stance = {
	position = {"BOTTOM",UIParent,-70,122}, --position
	scale = 1, --scale
	size = 30, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = false,
}
cfg.extra = {
	position = {"BOTTOM",UIParent,0,152}, --position
	scale = 1, --scale
	size = 50, --size of actionbar buttons
}
cfg.bag = {
	position = {"TOPRIGHT",Minimap,"BOTTOMRIGHT",-3,-2}, --position
	scale = 1, --scale
	fade = false,
}
cfg.vehicle = {
	position = {"BOTTOM",UIParent,0,122}, --position
	scale = 1, --scale
	size = 50, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
}
cfg.xp = {
	enable = true,
	position = {"TOPLEFT",UIParent,0,0},
	width = 436,
	height = 15,
}