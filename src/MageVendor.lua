local AddonName, Addon = ...
local version = "0.1.0";

BINDING_HEADER_LFGKEYBINDINGS = "MageVendor"

function onLoad()

	InitEvents()

	SLASH_MageVendor1 = "/magevendor";
	SLASH_MageVendor2 = "/mv";
	SlashCmdList["MageVendor"] = MageVendor_SlashHandler;

	Addon.debug = false
	Addon.name = AddonName

	Addon.isInitialized = true
end

local cmds = {};
function MageVendor_SlashHandler(msg)
    if(msg ~= "") then msg = string.lower(msg) end;
    if(not cmds[msg]) then 
		cmds["default"]();
		return;
	end

    cmds[msg]();
end

function cmds:default(...)
    DEFAULT_CHAT_FRAME:AddMessage("MageVendor: v" .. version);
end

function cmds:show(...)
    DEFAULT_CHAT_FRAME:AddMessage("MageVendor: show doesn't work just yet");
end

local frame, events = CreateFrame("Frame"), {};
function InitEvents()
	frame:SetScript("OnEvent", function(self, event, ...)
		events[event](self, ...);
	end);

	for e, v in pairs(events) do
		frame:RegisterEvent(e); -- Register all events for which handlers have been defined
	end
end 

function events:PLAYER_ENTERING_WORLD(...)
	DEFAULT_CHAT_FRAME:AddMessage("MageVendor loaded");
end

onLoad()
