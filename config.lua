local _, cfg = ... --export config
local addon, ns = ... --get addon namespace

--[[
Note to users new to a config.lua file:
	This is a file intended to provide configuration options,you edit these files quite simply. Make a change and
save the file. You can even edit the files while the game is loaded, just change the value save it then type /reload
or /rl into the game chat to realod the user interface.
	I highly recommend keeping all the punctuation in the same place as it can cause errors if you accidently remove
a comma.

Regards:
10leej aka Jos - [A] <Reforged> - Deviate Delight - WoW Classic
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
cfg.UnitFrames		= true 	--UnitFrames
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
cfg.AutoScaleUI		= true 	--Auto scales UI to be pixel perfect
cfg.UIscale		 	= 1 	--Manually set the UI scale (if AutoScale false)
cfg.AutoVendor		= true  --Automated repair (with guild funds) and sell greys
cfg.MaxCamera		= true  --Increases the Maximum camera distance beyond default

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
------------------------------------------[[UnitFrames]]------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.player = {
	position = {"CENTER", UIParent, "CENTER", 0, 0},
	height = 80,
	width = 200,
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
cfg.nameplates = { --not valid as Nameplates currently don't exist, yet

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
	fontsize = 14,
	justify = "CENTER",
}
--Time
cfg.time = {
	position = {"TOP", UIParent, "TOP", 0, -12},
	fontsize = 12,
}

--------------------------------------------------------------------------------------------------
---------------------------------------------[[Chat]]---------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.chat = {
	style = nil,
	size = 14,
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
	position = {"TOPRIGHT", Minimap, "TOPLEFT", -8, -4},
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
--Dereciated, I'll keep skinning the OG bags for now I think.
--------------------------------------------------------------------------------------------------
------------------------------------------[[ActionBars]]------------------------------------------
--------------------------------------------------------------------------------------------------
cfg.hidemacro = false
cfg.hidehotkey = false
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
	position = {"LEFT",UIParent,2,0}, --position
	scale = 1, --scale
	size = 36, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = false,
	use6x2 = true,
}
cfg.bar5 = {
	position = {"RIGHT",UIParent,-2,0}, --position
	scale = 1, --scale
	size = 36, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
	fade = false,
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
	position = {"BOTTOM",UIParent,-90,122}, --position
	scale = 1, --scale
	size = 30, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 0, --horizontal spacing
	fade = false,
}
cfg.extra = {
	position = {"BOTTOM",UIParent,0,152}, --position
	scale = 1, --scale
	size = 50, --size of actionbar buttons
}
cfg.bag = {
	enable = true,
	position = {"TOPRIGHT",Minimap,"BOTTOMRIGHT",-3,-4}, --position
	scale = 0.85, --scale
	fade = false,
}
cfg.vehicle = {
	position = {"BOTTOM",UIParent,0,160}, --position
	scale = 1, --scale
	size = 50, --size of actionbar buttons
	padding = 0, --verticle spacing
	margin = 4, --horizontal spacing
}
cfg.xp = {
	enable = true,
	position = {"TOPLEFT",UIParent,15,-15},
	width = 436,
	height = 15,
}
