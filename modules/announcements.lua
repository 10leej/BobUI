--this addon handles all announces
local _, cfg = ...
local addon, ns = ...

SlashCmdList["ABOUT"] = function()
	print("BobUI v6.0 developed by 10leej@wowinterface.com")
	print(" ")
    print("Slash Commands:")
    print("/rl --for UI Reload")
    print("/gm --to open Support/Help")
    print("/rc --run a Ready Check")
    print("/clc --Clears Combat log entries")
	print(" ")
	print("Features:")
	print("Auto Repair (with guild support filterable by if in raid group)")
	print("Auto Sells Greys")
	print("Clickable URL Links in chat")
	print(" ")
	print("Have fun and enjoy playing.")
end
SLASH_ABOUT1 = "/about"
SLASH_ABOUT2 = "/bobui"