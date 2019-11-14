local AddonName, Addon = ...
local version = "0.1.0";

BINDING_HEADER_LFGKEYBINDINGS = "MageVendor"

SLASH_MageVendor1 = "/magevendor";
SLASH_MageVendor2 = "/mv";
SlashCmdList["MageVendor"] = MageVendor_SlashHandler;

Addon.debug = false
Addon.name = AddonName

Addon.isInitialized = true

local cmds = {};
function MageVendor_SlashHandler(msg)
    if(msg ~= "") then msg = string.lower(msg) end;
    if(not cmds[msg]) then cmds["default"]() end;
    cmds[msg]();

	if(msg ~= "") then msg = string.lower(msg) end;
	if(msg == "show") then
		DEFAULT_CHAT_FRAME:AddMessage("MageVendor seems to be present");
	else
		DEFAULT_CHAT_FRAME:AddMessage("MageVendor: v" .. version);
	end
end

function cmds:default(...)
    DEFAULT_CHAT_FRAME:AddMessage("MageVendor: v" .. version);
end

function cmds:show(...)
    DEFAULT_CHAT_FRAME:AddMessage("MageVendor: show doesn't work just yet");
end